//
//  Train Name View.swift
//  NaTir
//
//  Created by David Bureš on 10.04.2023.
//

import SwiftUI

struct TrainNameView: View
{
    @State var train: Train
    @State var isShowingTrainAccessories: Bool

    @State var isShowingAmenitiesUnderTrainName: Bool = false
    @State var isShowingDelay: Bool = true

    var body: some View
    {
        if !isShowingAmenitiesUnderTrainName
        {
            HStack(alignment: .center, spacing: 15)
            {
                HStack(alignment: .center, spacing: 5)
                {
                    Image(systemName: train.iconName)

                    Text("\(train.type) \(train.id)")
                        .font(.title2)
                        .foregroundColor(.blue)
                }

                if isShowingTrainAccessories
                {
                    TrainAccessoriesListView(train: train)
                }
                
                if isShowingDelay
                {
                    if let trainDelay = train.delay?.delayInMinutes
                    {
                        PillText(text: "+ \(trainDelay) min", color: trainDelay < 15 ? .systemOrange : .red)
                    }
                }
            }
        }
        else
        {
            HStack(alignment: .top, spacing: 5)
            {
                Image(systemName: train.iconName)

                VStack(alignment: .leading, spacing: 5)
                {
                    Text("\(train.type) \(train.id)")
                        .font(.title2)
                        .foregroundColor(.blue)
                    
                    HStack(alignment: .center, spacing: 15) {
                        if isShowingTrainAccessories
                        {
                            TrainAccessoriesListView(train: train)
                        }
                        
                        if isShowingDelay
                        {
                            if let trainDelay = train.delay?.delayInMinutes
                            {
                                PillText(text: "+ \(trainDelay) min", color: trainDelay < 15 ? .systemOrange : .red)
                            }
                        }
                    }
                }
            }
        }
    }
}
