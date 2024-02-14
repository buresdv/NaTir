//
//  Ticket.swift
//  NaTir
//
//  Created by David Bureš on 11.04.2023.
//

import Foundation

struct Ticket: Identifiable, Codable, Equatable
{
    var id: UUID = UUID()
    
    let contents: String
    var dateSaved: Date
}
