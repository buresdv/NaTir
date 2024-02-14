//
//  Favorites Tracker.swift
//  NaTir
//
//  Created by David Bureš on 10.04.2023.
//

import Foundation

class FavoritesTracker: ObservableObject
{
    @Published var favorites: [Journey] = .init()
}
