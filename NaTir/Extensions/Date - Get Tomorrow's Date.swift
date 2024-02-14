//
//  Date - Get Tomorrow's Date.swift
//  NaTir
//
//  Created by David Bureš on 13.04.2023.
//

import Foundation

extension Date
{
    static var tomorrow: Date { return Date().dayAfter }
    static var today: Date { return Date() }
    var dayAfter: Date
    {
        return Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    }
}
