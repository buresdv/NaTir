//
//  Date - Convert to Presentable Format.swift
//  NaTir
//
//  Created by David Bureš on 08.04.2023.
//

import Foundation

extension Date
{
    func convertToPresentableFormat() -> String
    {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: self)
    }
    
    func convertToCompleteDate() -> String
    {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm, d. MMMM (EEEE)"
        
        return dateFormatter.string(from: self)
    }
    
    func convertToDayMonth() -> String
    {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d. M. (EE)"
        
        return dateFormatter.string(from: self)
    }
    
    func convertToFormatForPotniskiWebsiteLinkQuery() -> String
    {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        return dateFormatter.string(from: self)
    }
    
    func convertToRelativeFormat() -> String
    {
        let dateFormatter: RelativeDateTimeFormatter = RelativeDateTimeFormatter()
        dateFormatter.dateTimeStyle = .named
        dateFormatter.unitsStyle = .full
        
        return dateFormatter.localizedString(for: self, relativeTo: Date())
    }
}
