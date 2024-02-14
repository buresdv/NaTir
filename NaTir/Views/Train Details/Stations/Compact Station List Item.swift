//
//  Compact Station List Item.swift
//  NaTir
//
//  Created by David Bureš on 09.04.2023.
//

import SwiftUI

struct CompactStationListItem: View {
    
    @State var train: Train
    @State var station: TrainStop
    
    @State var isPartOfTrip: Bool
    @State var isLastStationOfTrip: Bool
    
    var addDelayToTimes: Bool
    
    var body: some View {
        VStack
        {
            HStack(alignment: .center, spacing: 10) {
                if isPartOfTrip || isLastStationOfTrip
                {
                    Text(station.stationName)
                }
                else
                {
                    Text(station.stationName)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 5) {
                    if let arrivalTime = station.arrivalTime
                    {
                        Text((arrivalTime + TimeInterval(addDelayToTimes ? train.delay!.delayInMinutes * 60 : 0)).convertToPresentableFormat())
                            .if(addDelayToTimes)
                        { view in
                                view
                                    .foregroundColor(.red)
                            }
                    }
                    else
                    {
                        Text("connections.train-detail.station-list.origin-station")
                    }
                    
                    if let departureTime = station.departureTime
                    {
                        Text((departureTime + TimeInterval(addDelayToTimes ? train.delay!.delayInMinutes * 60 : 0)).convertToPresentableFormat())
                            .if(addDelayToTimes)
                        { view in
                                view
                                    .foregroundColor(.red)
                            }
                    }
                    else
                    {
                        Text("connections.train-detail.station-list.terminal-station")
                    }
                }
            }
            .padding(5)
            
            Divider()
        }
        .padding(.horizontal)
        .contentShape(Rectangle())
        .if(isPartOfTrip) { view in
            view
                .background(Color(uiColor: .secondarySystemFill))
        }
        .if(isLastStationOfTrip) { view in
            view
                .background(Color(uiColor: .tertiarySystemGroupedBackground))
        }
    }
}
