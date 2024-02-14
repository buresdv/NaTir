//
//  Train Stop.swift
//  NaTir
//
//  Created by David Bureš on 09.04.2023.
//

import Foundation

struct TrainStop: Identifiable, Codable
{
    var id: UUID = UUID()
    
    let stationName: String
    
    let arrivalTime: Date?
    let departureTime: Date?
}
