//
//  Stations View.swift
//  NaTir
//
//  Created by David Bureš on 07.04.2023.
//

import MapKit
import SwiftUI

struct StationsView: View
{
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var locationManager: LocationManager

    @State private var searchText: String = ""

    @FocusState var isKeyboardFocused: Bool

    var body: some View
    {
        ZStack(alignment: .bottom)
        {
            MapView(region: locationManager.region)
                .ignoresSafeArea(.container, edges: .top)

            VStack
            {
                TextField("connections.station-search-field.connections-finder-sheet.placeholder", text: $searchText)
                    .focused($isKeyboardFocused)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .autocorrectionDisabled()

                Divider()

                if isKeyboardFocused
                {
                    ScrollView
                    {
                        LazyVStack
                        {
                            ForEach(searchText.isEmpty ? appState.stations : appState.stations.filter { $0.name.localizedCaseInsensitiveContains(searchText) })
                            { station in
                                StationListItem(station: station)
                                    .onTapGesture
                                    {
                                        searchText = station.name
                                        isKeyboardFocused = false
                                        
                                        locationManager.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: station.coordinate!.latitude, longitude: station.coordinate!.longitude), span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15))
                                    }
                            }
                        }
                    }
                    .frame(height: 200)
                    .animation(.easeIn(duration: 0.3), value: isKeyboardFocused)
                }
            }
            .background(.thinMaterial)
        }
    }
}
