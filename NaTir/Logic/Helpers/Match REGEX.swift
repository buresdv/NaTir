//
//  Match REGEX.swift
//  NaTir
//
//  Created by David Bureš on 14.04.2023.
//

import Foundation

func regexMatch(from string: String, regex: String) throws -> String
{
    guard let matchedRange = string.range(of: regex, options: .regularExpression) else { return "FAILED TO FIND MATCH" }
    
    return String(string[matchedRange])
}
