//
//  Connections Result View.swift
//  NaTir
//
//  Created by David Bureš on 08.04.2023.
//

import SwiftUI

struct ConnectionsResultView: View
{
    @EnvironmentObject var appState: AppState

    @ObservedObject var journeyTracker: JourneyTracker
    @ObservedObject var favoritesTracker: FavoritesTracker

    @State var desiredDepartureTime: Date

    @State private var journeyIsAlreadyInFavorites: Bool = false
    @State private var isLoadingAdditionalJourneys: Bool = false

    @State private var isRefreshingJourneys: Bool = false

    var body: some View
    {
        VStack
        {
            if journeyTracker.isLoadingJourneys
            {
                ProgressView
                {
                    Text("connections.process.finding-routes")
                }
            }
            else
            {
                if journeyTracker.foundJourneys.isEmpty
                {
                    VStack(alignment: .center, spacing: 15)
                    {
                        Text("😢")
                        Text("connections.could-not-find-connections")
                    }
                }
                else
                {
                    ScrollView
                    {
                        if isRefreshingJourneys
                        {
                            ProgressView
                            {
                                Text("connections.process.refreshing-routes")
                            }
                        }
                        ForEach(connectionsAfterTheSelectedJourney)
                        { connection in /// Show only the connections after the selected date
                            ConnectionResultRow(connection: connection)

                            Divider()
                        }

                        VStack(alignment: .center, spacing: 15)
                        {
                            if !isLoadingAdditionalJourneys
                            {
                                Text(connectionsAfterTheSelectedJourney.isEmpty ? "connections.status.no-connections-at-all" : "connections.status.no-connections-but-there-were-some-before")
                                    .foregroundColor(.gray)
                                Button
                                {
                                    Task(priority: .userInitiated)
                                    {
                                        isLoadingAdditionalJourneys = true

                                        let tomorrow: Date = Calendar.current.date(byAdding: .day, value: 1, to: desiredDepartureTime)!
                                        let strippedTomorrow: Date = tomorrow.removeTimestamp()
                                        let additionalJourneys: [Journey] = await getRoutes(fromStation: journeyTracker.foundJourneys.first!.from, toStation: journeyTracker.foundJourneys.first!.to, date: strippedTomorrow, appState: appState)

                                        for additionalJourney in additionalJourneys
                                        {
                                            journeyTracker.foundJourneys.append(additionalJourney)
                                        }

                                        isLoadingAdditionalJourneys = false
                                    }
                                } label: {
                                    Text("connections.process.load-tomorrow-routes")
                                }
                                .buttonStyle(.borderedProminent)
                            }
                            else
                            {
                                ProgressView
                                {
                                    Text("connections.process.finding-routes")
                                }
                            }
                        }
                        .padding()
                    }
                    .onAppear
                    {
                        print("WTF")
                        print("Found trains: \(journeyTracker.foundJourneys)")
                        print("Picked date: \(desiredDepartureTime)")

                        if favoritesTracker.favorites.contains(where: { $0.from.id == journeyTracker.foundJourneys.first!.from.id }) && favoritesTracker.favorites.contains(where: { $0.to.id == journeyTracker.foundJourneys.first!.to.id })
                        { /// If the beginning station from the search matches the beginning station from the selected route (+ the same with end station), it means that this connection is in the favorites. Mark it as such.
                            journeyIsAlreadyInFavorites = true
                        }
                    }
                    .refreshable
                    {
                        Task(priority: .userInitiated)
                        {
                            isRefreshingJourneys = true

                            journeyTracker.foundJourneys = await getRoutes(fromStation: journeyTracker.foundJourneys.first!.from, toStation: journeyTracker.foundJourneys.last!.to, date: desiredDepartureTime, appState: appState)

                            isRefreshingJourneys = false
                        }
                    }
                    .toolbar
                    {
                        ToolbarItem(placement: .navigationBarTrailing)
                        {
                            Button
                            {
                                if journeyIsAlreadyInFavorites
                                {
                                    print("This journey is already in the favorites. Removing it.")

                                    let indexOfExistingJourney: Int? = favoritesTracker.favorites.firstIndex
                                    { favoritedJourney in
                                        favoritedJourney.from.id == journeyTracker.foundJourneys.first!.from.id && favoritedJourney.to.id == journeyTracker.foundJourneys.first!.to.id
                                    }
                                    if let indexOfExistingJourney
                                    {
                                        favoritesTracker.favorites.remove(at: indexOfExistingJourney)
                                        journeyIsAlreadyInFavorites = false
                                        AppConstants.hapticFeedbackGenerator.notificationOccurred(.success)
                                    }
                                }
                                else
                                {
                                    print("This journey is not in favorites yet. Adding.")

                                    favoritesTracker.favorites.insert(journeyTracker.foundJourneys.first!, at: 0)
                                    journeyIsAlreadyInFavorites = true
                                    AppConstants.hapticFeedbackGenerator.notificationOccurred(.success)
                                }

                            } label: {
                                Label("Add to Favorites", systemImage: journeyIsAlreadyInFavorites ? "star.fill" : "star")
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("title.routes")
        .navigationBarTitleDisplayMode(.inline)
    }

    var connectionsAfterTheSelectedJourney: [Journey]
    {
        return journeyTracker.foundJourneys.filter
        { $0.trainsInvolved.first!.departureTime > desiredDepartureTime
        }
    }
}
