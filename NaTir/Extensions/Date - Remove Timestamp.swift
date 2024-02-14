//
//  Date - Remove Timestamp.swift
//  NaTir
//
//  Created by David Bureš on 12.04.2023.
//

import Foundation

extension Date
{
    func removeTimestamp() -> Date
    {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self))
        else
        {
            fatalError("Failed to strip time from Date object")
        }
        return date
    }
}
