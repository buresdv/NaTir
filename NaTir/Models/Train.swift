//
//  Train.swift
//  NaTir
//
//  Created by David Bureš on 08.04.2023.
//

import Foundation

struct Train: Identifiable, Equatable, Codable
{
    static func == (lhs: Train, rhs: Train) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: Int
    let type: String
    
    var iconName: String {
        
        var iconName: String = ""
        
        if self.type == "ICS" || self.type == "IC"
        {
            iconName = "train.side.front.car"
        }
        else if self.type != "BUS"
        {
            iconName = "tram"
        }
        else
        {
            iconName = "bus"
        }
        
        return iconName
    }
    
    let allowsBikes: Bool
    let hasWifi: Bool
    let hasFirstClass: Bool
    var isReplacementBus: Bool {
        if self.type == "BUS"
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    let travelingTime: TimeInterval?
    var delay: Delay?
    
    let departureTime: Date
    let destinationArrivalTime: Date
    
    let originStation: Station
    let destinationStation: Station
    
    var allStops: [TrainStop]?
}
