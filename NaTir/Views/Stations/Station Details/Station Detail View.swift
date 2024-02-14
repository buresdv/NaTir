//
//  Station Detail View.swift
//  NaTir
//
//  Created by David Bureš on 09.04.2023.
//

import MapKit
import SwiftUI

struct StationDetailView: View
{
    @EnvironmentObject var appState: AppState

    @State var station: Station

    var body: some View
    {
        VStack(alignment: .leading, spacing: 10)
        {
            Text(station.name)
                .font(.title2)

            if let stationCoordinates = station.coordinate
            {
                MapView(region: MKCoordinateRegion(center: stationCoordinates, latitudinalMeters: 300, longitudinalMeters: 300))
            }
        }
        .onAppear
        {
            #warning("TODO: Make this work. For some reason, it centers on my location")
            station.coordinate = appState.stations.first(where: { station.id == $0.id })?.coordinate
        }
    }
}
