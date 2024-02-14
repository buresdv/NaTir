//
//  Delay.swift
//  NaTir
//
//  Created by David Bureš on 14.04.2023.
//

import Foundation

struct Delay: Codable
{
    var affectedStation: Station
    let delayInMinutes: Int
}
