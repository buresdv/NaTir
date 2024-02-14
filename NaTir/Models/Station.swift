//
//  Station.swift
//  NaTir
//
//  Created by David Bureš on 07.04.2023.
//

import Foundation
import MapKit

struct Station: Identifiable, Codable
{
    let id: Int
    
    let name: String
    
    var coordinate: CLLocationCoordinate2D?
    
    /*
    func convertSavedJourneyStationsToStationStruct(savedJourney: SaveableJourney, listOfAllStations: [Station]) -> Station
    {
        let 
    }
     */
}
