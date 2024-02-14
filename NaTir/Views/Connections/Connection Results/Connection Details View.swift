//
//  Connection Details View.swift
//  NaTir
//
//  Created by David Bureš on 09.04.2023.
//

import SwiftUI

struct ConnectionDetailsView: View
{
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var calendarManager: CalendarManager

    @State var connection: Journey

    @State var transferTimes: [TimeInterval] = .init()
    @State private var isCalculatingTransferTimes: Bool = true

    var body: some View
    {
        VStack(alignment: .leading, spacing: 0)
        {
            VStack(alignment: .leading, spacing: 15)
            {
                Grid(alignment: .leading)
                {
                    GridRow(alignment: .center)
                    {
                        Image(systemName: "location.circle.fill")
                        NavigationLink
                        {
                            StationDetailView(station: connection.trainsInvolved.first!.originStation)
                        } label: {
                            Text(connection.trainsInvolved.first!.originStation.name)
                        }
                        .buttonStyle(.plain)
                    }
                    GridRow(alignment: .center)
                    {
                        Image(systemName: "flag.circle.fill")
                        NavigationLink
                        {
                            StationDetailView(station: connection.trainsInvolved.last!.destinationStation)
                        } label: {
                            Text(connection.trainsInvolved.last!.destinationStation.name)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .font(.title2)
                .foregroundColor(.blue)

                HStack(alignment: .center, spacing: 10)
                {
                    HStack(alignment: .center, spacing: 5)
                    {
                        Image(systemName: "clock")
                        Text(connection.lengthString)
                            .foregroundColor(.gray)
                    }
                    HStack(alignment: .center, spacing: 5)
                    {
                        Image(systemName: "calendar")
                        Text(connection.trainsInvolved.first!.departureTime.convertToDayMonth())
                            .foregroundColor(.gray)
                    }

                    Spacer()
                }
            }
            .onAppear
            {
                print("App state status: \(appState.isShowingAddingEventToCalendarFailedAlert)")
            }
            .padding()

            Divider()

            ScrollView
            {
                LazyVStack
                {
                    ForEach(connection.trainsInvolved.indices, id: \.self)
                    { indice in
                        VStack
                        {
                            VStack(alignment: .leading, spacing: 10)
                            {
                                VStack
                                {
                                    GroupBox
                                    {
                                        NavigationLink
                                        {
                                            StationDetailView(station: connection.trainsInvolved[indice].originStation)
                                        } label: {
                                            HStack(alignment: .firstTextBaseline)
                                            {
                                                Text(connection.trainsInvolved[indice].originStation.name)

                                                Spacer()

                                                Text(connection.trainsInvolved[indice].departureTime.convertToPresentableFormat())

                                                NavigationArrowThing()
                                            }
                                            .contentShape(Rectangle()) /// This has to be there, otherwise the entire row won't be tappable
                                        }
                                        .buttonStyle(.plain)
                                    }

                                    GroupBox
                                    {
                                        NavigationLink
                                        {
                                            StationDetailView(station: connection.trainsInvolved[indice].destinationStation)
                                        } label: {
                                            HStack(alignment: .firstTextBaseline)
                                            {
                                                Text(connection.trainsInvolved[indice].destinationStation.name)

                                                Spacer()

                                                Text(connection.trainsInvolved[indice].destinationArrivalTime.convertToPresentableFormat())

                                                NavigationArrowThing()
                                            }
                                            .contentShape(Rectangle()) /// This has to be there, otherwise the entire row won't be tappable
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }

                                NavigationLink
                                {
                                    TrainDetailView(train: connection.trainsInvolved[indice], isShowingTrainAccessories: true)
                                } label: {
                                    TrainNameView(train: connection.trainsInvolved[indice], isShowingTrainAccessories: true)
                                }

                                if connection.trainsInvolved[indice].type == "BUS"
                                {
                                    Text("connections.results.train-bus-replacement")
                                        .foregroundColor(.red)
                                }

                                if !isCalculatingTransferTimes
                                {
                                    if !transferTimes.isEmpty
                                    {
                                        if indice < transferTimes.count
                                        {
                                            LabeledDivider(label: "connections.results.transfers-wait-\(transferTimes[indice].convertToPresentableFormat())", horizontalPadding: 10, color: .gray)
                                        }
                                    }
                                }
                            }
                        }
                        .padding()
                    }

                    BuyTicketsButton(price: connection.price, isFullWidth: true)
                    {
                        print("Ahoj")
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationTitle("title.journey-details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar
        {
            ToolbarItem(placement: .navigationBarTrailing)
            {
                if !appState.hasSuccessfullyAddedJourneyToCalendar
                {
                    Button
                    {
                        calendarManager.addJourneyToCalendar(journey: connection, appState: appState)
                    } label: {
                        Label("connections.actions.add-to-calendar", systemImage: "calendar.badge.plus")
                    }
                }
                else
                {
                    Button {
                        print("Ahoj")
                    } label: {
                        Label("connections.actions.add-to-calendar", systemImage: "checkmark")
                    }

                }
            }
        }
        .onAppear
        {
            if isCalculatingTransferTimes
            {
                for indice in connection.trainsInvolved.indices
                {
                    if indice < connection.trainsInvolved.count - 1
                    {
                        print("Comparing arrival time \(connection.trainsInvolved[indice].destinationArrivalTime) to departure time \(connection.trainsInvolved[indice + 1].departureTime)")

                        print("User will have around \(connection.trainsInvolved[indice + 1].departureTime.timeIntervalSince(connection.trainsInvolved[indice].destinationArrivalTime)) seconds to transfer")

                        transferTimes.append(connection.trainsInvolved[indice + 1].departureTime.timeIntervalSince(connection.trainsInvolved[indice].destinationArrivalTime))
                    }
                }

                print("Transfer Times: \(transferTimes)")

                isCalculatingTransferTimes = false
            }
        }
        .alert(isPresented: $appState.isShowingAddingEventToCalendarFailedAlert) {
            Alert(title: Text("alert.calendar.could-not-add-journey.title"), message: Text("alert.calendar.could-not-add-journey.message"), dismissButton: .default(Text("action.close"), action: {
                appState.isShowingAddingEventToCalendarFailedAlert.toggle()
            }))
        }
    }
}
