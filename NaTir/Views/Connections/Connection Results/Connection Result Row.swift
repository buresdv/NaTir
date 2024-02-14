//
//  Connection Result Row.swift
//  NaTir
//
//  Created by David Bureš on 08.04.2023.
//

import SwiftUI

struct ConnectionResultRow: View
{
    @State var connection: Journey
    
    @State var transferTracker: [String] = .init()
    @State var involvedTrainsTracker: [String] = .init()
    
    @State var hasCalculatedTransfers: Bool = false

    var body: some View
    {
        VStack(alignment: .leading, spacing: 10)
        {
            HStack(alignment: .center, spacing: 10) {
                ForEach(connection.trainsInvolved)
                { involvedTrain in
                    HStack(alignment: .center, spacing: 5) {
                        Text("\(involvedTrain.type) \(involvedTrain.id)")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                        if let trainDelay = involvedTrain.delay
                        {
                            PillText(text: "+ \(trainDelay.delayInMinutes) min", color: trainDelay.delayInMinutes < 15 ? .systemOrange : .red)
                        }
                    }
                    
                }
            }
            
            HStack(alignment: .center, spacing: 20)
            {
                NavigationLink {
                    ConnectionDetailsView(connection: connection)
                } label: {
                    HStack(alignment: .center, spacing: 15) {
                        VStack(alignment: .leading, spacing: 5) {
                            
                            HStack(alignment: .center, spacing: 5) {
                                Text(connection.trainsInvolved.first!.originStation.name)
                                Spacer()
                                Text(connection.trainsInvolved.first!.departureTime.convertToPresentableFormat())
                            }
                            
                            if transferTracker.count > 0
                            {
                                Text("connections.results.transfers-title-\(transferTracker.joined(separator: ", "))")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                            }
                            
                            HStack(alignment: .center, spacing: 5) {
                                Text(connection.trainsInvolved.last!.destinationStation.name)
                                Spacer()
                                Text(connection.trainsInvolved.last!.destinationArrivalTime.convertToPresentableFormat())
                            }
                        }
                    }
                }
                .buttonStyle(.plain)
                
                NavigationArrowThing()
            }

            HStack(alignment: .center, spacing: 10) {
                
                HStack(alignment: .center, spacing: 5) {
                    Image(systemName: "clock")
                    Text(connection.lengthString)
                        .foregroundColor(.gray)
                }
                HStack(alignment: .center, spacing: 5) {
                    Image(systemName: "calendar")
                    Text(connection.trainsInvolved.first!.departureTime.convertToDayMonth())
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                BuyTicketsButton(price: connection.price, isFullWidth: false) {
                    print("Ahoj")
                }
            }
            
        }
        .padding()
        .onAppear
        {
            /// Only fire this off once so we don't get an array where it keeps getting appended every time they go back to this screen
            if !hasCalculatedTransfers
            {
                /// Get the transfers
                for indice in connection.trainsInvolved.indices
                {
                    if indice < connection.trainsInvolved.count - 1
                    {
                        print("Comparing \(connection.trainsInvolved[indice].destinationStation.name) to \(connection.trainsInvolved[indice + 1].originStation.name)")
                        
                        if connection.trainsInvolved[indice].destinationStation.id == connection.trainsInvolved[indice + 1].originStation.id
                        {
                            print("There is a transfer in \(connection.trainsInvolved[indice])")
                            
                            transferTracker.append(connection.trainsInvolved[indice].destinationStation.name)
                        }
                        else
                        {
                            print("There is no transfer")
                        }
                    }
                }
                
                /// Get the names of all the involved trains
                for train in connection.trainsInvolved
                {
                    involvedTrainsTracker.append("\(train.type) \(train.id)")
                }
                
                hasCalculatedTransfers = true
            }
        }
    }
}
