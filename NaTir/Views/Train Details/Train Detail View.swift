//
//  Train Detail View.swift
//  NaTir
//
//  Created by David Bureš on 09.04.2023.
//

import SwiftUI

struct TrainDetailView: View
{
    @State var train: Train
    @State var isShowingTrainAccessories: Bool

    @State private var allStops: [TrainStop]?

    @State private var isLoadingTrainDetails: Bool = true

    @State private var indexOfTripStartStation: Int = 0
    @State private var indexOfTripEndStation: Int = 0

    @State private var addDelayToStationTimes: Bool = false

    var body: some View
    {
        VStack(alignment: .leading, spacing: 0)
        {
            if !isLoadingTrainDetails
            {
                HStack(alignment: .top)
                {
                    TrainNameView(train: train, isShowingTrainAccessories: true, isShowingAmenitiesUnderTrainName: true, isShowingDelay: false)

                    Spacer()

                    if train.delay != nil
                    {
                        VStack(alignment: .trailing, spacing: 10)
                        {
                            Toggle(isOn: $addDelayToStationTimes)
                            {
                                Text("connections.option.add-delay")
                                    .font(.caption)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .onChange(of: addDelayToStationTimes) { newValue in
                                print("Add delay changed in parent view: \(newValue)")
                            }

                            if let trainDelay = train.delay?.delayInMinutes
                            {
                                PillText(text: "+ \(trainDelay) min", color: trainDelay < 15 ? .systemOrange : .red)
                            }
                        }
                    }
                }
                .padding()

                Divider()

                TabView
                {
                    if let allStops
                    {
                        ScrollView
                        {
                            VStack(spacing: 0)
                            {
                                ForEach(Array(allStops.enumerated()), id: \.offset)
                                { offset, stop in
                                    if offset == indexOfTripStartStation
                                    {
                                        CompactStationListItem(train: train, station: stop, isPartOfTrip: false, isLastStationOfTrip: true, addDelayToTimes: addDelayToStationTimes)
                                    }
                                    else if offset > indexOfTripStartStation && offset < indexOfTripEndStation
                                    {
                                        CompactStationListItem(train: train, station: stop, isPartOfTrip: true, isLastStationOfTrip: false, addDelayToTimes: addDelayToStationTimes)
                                    }
                                    else if offset == indexOfTripEndStation
                                    {
                                        CompactStationListItem(train: train, station: stop, isPartOfTrip: false, isLastStationOfTrip: true, addDelayToTimes: addDelayToStationTimes)
                                    }
                                    else
                                    {
                                        CompactStationListItem(train: train, station: stop, isPartOfTrip: false, isLastStationOfTrip: false, addDelayToTimes: addDelayToStationTimes)
                                    }
                                }
                            }
                        }
                        .tabItem
                        {
                            Text("connections.train-detail.tab.all-stops")
                        }
                    }
                    ScrollView
                    {
                        VStack(alignment: .leading, spacing: 20)
                        {
                            if train.isReplacementBus
                            {
                                HStack(alignment: .top, spacing: 15)
                                {
                                    AccessoryItem(iconName: "bus")
                                        .padding(.leading)
                                    Text("connections.train-detail.explanation.train-is-replaced-by-bus.text")
                                }
                                .border(.red)
                            }
                            if train.hasFirstClass
                            {
                                HStack(alignment: .top, spacing: 15)
                                {
                                    AccessoryItem(number: 1)
                                        .padding(.leading)
                                    Text("connections.train-detail.explanation.train-has-first-class.text")
                                }
                                .border(.blue)
                            }
                            HStack(alignment: .top, spacing: 15)
                            {
                                AccessoryItem(number: 2)
                                    .padding(.leading)
                                Text("connections.train-detail.explanation.train-has-second-class.text")
                            }
                            .border(.yellow)
                            if train.hasWifi
                            {
                                HStack(alignment: .top, spacing: 15)
                                {
                                    AccessoryItem(iconName: "wifi")
                                        .padding(.leading)
                                    Text("connections.train-detail.explanation.train-has-wifi")
                                }
                                .border(.black)
                            }
                            if train.allowsBikes
                            {
                                HStack(alignment: .top, spacing: 15)
                                {
                                    AccessoryItem(iconName: "bicycle")
                                        .padding(.leading)
                                    Text("connections.train-detail.explanation.train-allows-bikes")
                                }
                                .border(.yellow)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    }
                    .padding()
                    .tabItem
                    {
                        Text("connections.train-detail.tab.legend")
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
            }
            else
            {
                ProgressView()
            }
        }
        .navigationTitle("title.train-info")
        .navigationBarTitleDisplayMode(.inline)
        .task(priority: .userInitiated)
        {
            isLoadingTrainDetails = true

            allStops = await getTrainStops(trainID: train.id, date: Date())

            indexOfTripStartStation = allStops!.firstIndex(where: { $0.stationName == train.originStation.name })!
            indexOfTripEndStation = allStops!.firstIndex(where: { $0.stationName == train.destinationStation.name })!

            print("Index of start station: \(indexOfTripStartStation)")
            print("Index of end station: \(indexOfTripEndStation)")

            isLoadingTrainDetails = false
        }
        .onAppear
        {
            UIPageControl.appearance().currentPageIndicatorTintColor = .darkText
            UIPageControl.appearance().pageIndicatorTintColor = .placeholderText
            UIPageControl.appearance().backgroundStyle = .prominent
        }
    }
}
