//
//  Combine Date with Time.swift
//  NaTir
//
//  Created by David Bureš on 12.04.2023.
//

import Foundation

func combineDateWithTime(date: Date, time: Date) -> Date?
{
    let calendar = NSCalendar.current

    let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
    let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: time)

    var mergedComponents: DateComponents = DateComponents()
    mergedComponents.year = dateComponents.year
    mergedComponents.month = dateComponents.month
    mergedComponents.day = dateComponents.day
    mergedComponents.hour = timeComponents.hour
    mergedComponents.minute = timeComponents.minute
    mergedComponents.second = timeComponents.second

    return calendar.date(from: mergedComponents)
}
