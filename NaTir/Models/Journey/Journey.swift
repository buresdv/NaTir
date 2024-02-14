//
//  Journey.swift
//  NaTir
//
//  Created by David Bureš on 08.04.2023.
//

import Foundation

struct Journey: Identifiable, Equatable, Codable
{
    static func == (lhs: Journey, rhs: Journey) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: UUID = UUID()
    
    let from: Station
    let to: Station
    
    let lengthString: String
    
    let trainsInvolved: [Train]
    
    let price: Double
}
