//
//  Decode From File.swift
//  NaTir
//
//  Created by David Bureš on 11.04.2023.
//

import Foundation

internal enum TypeToDecode
{
    case Journey, Ticket
}
internal enum DecodingError: Error
{
    case failedtoReadFile, failedToDecode
}

func decodeStructFromFile(fromURL: URL, typeToDecode: TypeToDecode) throws -> any Codable
{
    do
    {
        let rawData: Data = try Data(contentsOf: fromURL, options: .mappedIfSafe)
        
        do
        {
            switch typeToDecode {
                case .Journey:
                    return try JSONDecoder().decode([Journey].self, from: rawData)
                    
                case .Ticket:
                    return try JSONDecoder().decode([Ticket].self, from: rawData)
            }
        }
        catch let decodingError
        {
            print("Failed to decode loaded data: \(decodingError.localizedDescription)")
            throw DecodingError.failedToDecode
        }
    }
    catch let fileReadingError
    {
        print("Failed to load data from file: \(fileReadingError.localizedDescription)")
        throw DecodingError.failedtoReadFile
    }
}
