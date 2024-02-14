//
//  Journey Tracker.swift
//  NaTir
//
//  Created by David Bureš on 08.04.2023.
//

import Foundation

class JourneyTracker: ObservableObject
{
    @Published var foundJourneys: [Journey] = .init()
    
    @Published var isLoadingJourneys: Bool = true
}
