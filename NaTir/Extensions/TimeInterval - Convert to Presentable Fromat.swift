//
//  TimeInterval - Convert to Presentable Fromat.swift
//  NaTir
//
//  Created by David Bureš on 09.04.2023.
//

import Foundation

extension TimeInterval
{
    func convertToPresentableFormat() -> String
    {
        let formatter: DateComponentsFormatter = DateComponentsFormatter()
        formatter.unitsStyle = .brief
        formatter.allowedUnits = [.hour, .minute]
        formatter.zeroFormattingBehavior = .dropAll
        
        return formatter.string(from: self)!
    }
    
    func convertToCustomPresentableFormat(style: DateComponentsFormatter.UnitsStyle, allowedUnits: NSCalendar.Unit) -> String
    {
        let formatter: DateComponentsFormatter = DateComponentsFormatter()
        formatter.unitsStyle = style
        formatter.allowedUnits = allowedUnits
        formatter.zeroFormattingBehavior = .dropAll
        
        return String(formatter.string(from: self)!.dropFirst())
    }
}
