//
//  History Tracker.swift
//  NaTir
//
//  Created by David Bureš on 10.04.2023.
//

import Foundation

class HistoryTracker: ObservableObject
{
    @Published var journeys: [Journey] = .init()
}
