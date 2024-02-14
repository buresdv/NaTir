//
//  Connections View.swift
//  NaTir
//
//  Created by David Bureš on 07.04.2023.
//

import CoreLocation
import SwiftUI

struct ConnectionsView: View
{
    @EnvironmentObject var appState: AppState
    
    @AppStorage("maxAllowedHistoryItems") var maxAllowedHistoryItems: Int = 10

    @StateObject var journeyTracker: JourneyTracker = .init()

    @ObservedObject var favoritesTracker: FavoritesTracker
    @ObservedObject var historyTracker: HistoryTracker

    @State var debugBody: String = "Loading..."

    @State var originStation: Station = .init(id: 0, name: "", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
    @State var destinationStation: Station = .init(id: 0, name: "", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))

    @State var originStationSearchTerm: String = ""
    @State var destinationStationSearchTerm: String = ""

    @State var pickedDate: Date = .init()

    @State var isShowingOriginStationSelectorSheet: Bool = false
    @State var isShowingDestinationStationSelectorSheet: Bool = false

    @State private var navigationAction: Int? = 0

    var body: some View
    {
        NavigationView
        {
            VStack(alignment: .leading, spacing: 0)
            {
                VStack
                {
                    VStack(alignment: .leading, spacing: 10)
                    {
                        VStack(alignment: .leading, spacing: 2)
                        {
                            Text("connections.finder.from")
                                .font(.callout)
                            FakeTextField(placeholder: "connections.station-search-field.placeholder", station: $originStation)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .onTapGesture
                        {
                            isShowingOriginStationSelectorSheet = true
                        }
                        .sheet(isPresented: $isShowingOriginStationSelectorSheet)
                        {
                            StationList(searchTerm: $originStationSearchTerm, selectedStation: $originStation, isShowingSheet: $isShowingOriginStationSelectorSheet)
                        }

                        VStack(alignment: .leading, spacing: 2)
                        {
                            Text("connections.finder.to")
                                .font(.callout)
                            FakeTextField(placeholder: "connections.station-search-field.placeholder", station: $destinationStation)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .onTapGesture
                        {
                            isShowingDestinationStationSelectorSheet = true
                        }
                        .sheet(isPresented: $isShowingDestinationStationSelectorSheet)
                        {
                            StationList(searchTerm: $destinationStationSearchTerm, selectedStation: $destinationStation, isShowingSheet: $isShowingDestinationStationSelectorSheet)
                        }

                        VStack(alignment: .leading, spacing: 2)
                        {
                            Text("connections.finder.desired-date-time")
                                .font(.callout)
                            DatePicker(selection: $pickedDate, displayedComponents: [.date, .hourAndMinute])
                            {
                                Text("")
                            }
                            .labelsHidden()
                        }
                    }

                    HStack(alignment: .center, spacing: 10)
                    {
                        Spacer()

                        Button
                        {
                            journeyTracker.isLoadingJourneys = true

                            journeyTracker.foundJourneys = .init()

                            print("Origin station: \(originStation.name)-\(originStation.id)")
                            print("Destination station: \(destinationStation.name)-\(destinationStation.id)")

                            self.navigationAction = 1

                            Task(priority: .userInitiated)
                            {
                                journeyTracker.foundJourneys = await getRoutes(fromStation: originStation, toStation: destinationStation, date: pickedDate, appState: appState)

                                journeyTracker.isLoadingJourneys = false

                                print("Will try to append \(journeyTracker.foundJourneys)")

                                historyTracker.journeys.insert(Journey(from: originStation, to: destinationStation, lengthString: "", trainsInvolved: [], price: 0), at: 0)
                                if historyTracker.journeys.count >= maxAllowedHistoryItems
                                {
                                    historyTracker.journeys.removeLast()
                                }
                            }
                        } label: {
                            Label("action.search", systemImage: "magnifyingglass")
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(originStation.name.isEmpty && destinationStation.name.isEmpty)
                    }

                    NavigationLink(destination: ConnectionsResultView(journeyTracker: journeyTracker, favoritesTracker: favoritesTracker, desiredDepartureTime: pickedDate), tag: 1, selection: $navigationAction)
                    {
                        Text("")
                    }
                }
                .padding()

                Divider()

                List
                {
                    Section("connections.favorite-routes")
                    {
                        if !favoritesTracker.favorites.isEmpty
                        {
                            ForEach(favoritesTracker.favorites.indices, id: \.self)
                            { indice in
                                HStack(alignment: .center, spacing: 10)
                                {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(Color(uiColor: .lightGray))
                                    Text("\(favoritesTracker.favorites[indice].from.name) → \(favoritesTracker.favorites[indice].to.name)")
                                }
                                .onTapGesture
                                {
                                    let originStationFromFavorites = favoritesTracker.favorites[indice].from
                                    let destinationStationFromFavorites = favoritesTracker.favorites[indice].to

                                    print("\(originStationFromFavorites.name) -> \(destinationStationFromFavorites.name)")

                                    journeyTracker.isLoadingJourneys = true

                                    journeyTracker.foundJourneys = .init()

                                    self.navigationAction = 1

                                    Task(priority: .userInitiated)
                                    {
                                        journeyTracker.foundJourneys = await getRoutes(fromStation: originStationFromFavorites, toStation: destinationStationFromFavorites, date: Date(), appState: appState)

                                        journeyTracker.isLoadingJourneys = false
                                    }
                                }
                                .swipeActions(edge: .trailing, allowsFullSwipe: true)
                                {
                                    Button
                                    {
                                        print("Would remove \(favoritesTracker.favorites[indice])")
                                        favoritesTracker.favorites.remove(at: indice)
                                    } label: {
                                        Label("action.remove-from-favorites", systemImage: "star.slash")
                                    }
                                    .tint(.yellow)
                                }
                            }
                        }
                        else
                        {
                            Text("connection.favorite-routes.no-favorites-found.text")
                                .foregroundColor(.secondary)
                                .font(.callout)
                        }
                    }
                    if !historyTracker.journeys.isEmpty
                    {
                        Section("connections.routes-history")
                        {
                            ForEach(historyTracker.journeys.indices, id: \.self)
                            { indice in
                                HStack(alignment: .center, spacing: 10)
                                {
                                    Image(systemName: "clock.arrow.circlepath")
                                        .foregroundColor(Color(uiColor: .lightGray))
                                    Text("\(historyTracker.journeys[indice].from.name) → \(historyTracker.journeys[indice].to.name)")
                                }
                                .onTapGesture
                                {
                                    let originStationFromHistory = historyTracker.journeys[indice].from
                                    let destinationStationFromHistory = historyTracker.journeys[indice].to

                                    print("\(originStationFromHistory.name) -> \(destinationStationFromHistory.name)")

                                    journeyTracker.isLoadingJourneys = true

                                    journeyTracker.foundJourneys = .init()

                                    print("Origin station: \(originStationFromHistory.name)-\(originStation.id)")
                                    print("Destination station: \(destinationStationFromHistory.name)-\(destinationStation.id)")

                                    self.navigationAction = 1

                                    Task(priority: .userInitiated)
                                    {
                                        journeyTracker.foundJourneys = await getRoutes(fromStation: originStationFromHistory, toStation: destinationStationFromHistory, date: Date(), appState: appState)

                                        journeyTracker.isLoadingJourneys = false
                                    }
                                }
                                .swipeActions(edge: .trailing, allowsFullSwipe: true)
                                {
                                    Button
                                    {
                                        print("Would remove \(historyTracker.journeys[indice])")
                                        historyTracker.journeys.remove(at: indice)
                                    } label: {
                                        Label("Remove from History", systemImage: "trash")
                                    }
                                    .tint(.red)
                                }
                            }
                        }
                    }
                }

                Spacer()
            }
            .navigationTitle("title.connections")
        }
    }
}
