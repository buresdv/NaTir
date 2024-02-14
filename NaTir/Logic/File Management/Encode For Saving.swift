//
//  Encode For FSaving.swift
//  NaTir
//
//  Created by David Bureš on 11.04.2023.
//

import Foundation

internal enum EncodingError: Error
{
    case failedToEncode
}

func encodeForSaving(object: any Codable) throws -> Data
{
    do
    {
        return try JSONEncoder().encode(object)
    }
    catch let encodingError
    {
        print("Failed while encoding struct: \(encodingError.localizedDescription)")
        throw EncodingError.failedToEncode
    }
}
