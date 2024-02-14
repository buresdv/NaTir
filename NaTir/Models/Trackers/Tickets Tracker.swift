//
//  Tickets Tracker.swift
//  NaTir
//
//  Created by David Bureš on 11.04.2023.
//

import Foundation

class TicketsTracker: ObservableObject
{
    @Published var savedtickets: [Ticket] = .init()
}
