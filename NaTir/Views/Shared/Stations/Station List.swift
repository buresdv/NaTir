//
//  Station List.swift
//  NaTir
//
//  Created by David Bureš on 07.04.2023.
//

import SwiftUI

struct StationList: View
{
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var locationManager: LocationManager

    @Binding var searchTerm: String

    @Binding var selectedStation: Station

    @Binding var isShowingSheet: Bool

    @FocusState var isSearchFieldFocused: Bool

    var body: some View
    {
        VStack
        {
            HStack(alignment: .center, spacing: 10)
            {
                TextField("connections.station-search-field.connections-finder-sheet.placeholder", text: $searchTerm)
                    .focused($isSearchFieldFocused)
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled()

                Button
                {
                    isShowingSheet.toggle()
                } label: {
                    Text("action.cancel")
                }
            }
            .padding()

            List
            {
                if locationManager.areLocationServicesEnabled && searchTerm.isEmpty /// Only show the nearest station if the user has enabled location tracking
                {
                    Section("connections.connections-finder-sheet.nearest-station")
                    {
                        #warning("TODO: Fix this. It still doesn't work")
                        let nearestStations: Station = appState.stations.first(where: { $0.coordinate!.longitude >= locationManager.region.center.longitude && $0.coordinate!.latitude >= locationManager.region.center.latitude }) ?? appState.stations.first!
                        StationListItem(station: nearestStations, stationIconName: "scope")
                            .onTapGesture
                            {
                                selectedStation = nearestStations

                                isShowingSheet = false
                            }
                    }
                }
                Section("connections.connections-finder-sheet.all-stations")
                {
                    ForEach(searchTerm.isEmpty ? appState.stations : appState.stations.filter { $0.name.localizedCaseInsensitiveContains(searchTerm) })
                    { station in
                        StationListItem(station: station)
                            .onTapGesture
                            {
                                selectedStation = station

                                isShowingSheet = false
                            }
                    }
                }
            }
            .frame(maxHeight: .infinity)
            .onAppear
            {
                isSearchFieldFocused = true
            }
        }
    }
}
