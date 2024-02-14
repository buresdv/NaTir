//
//  Create Empty File.swift
//  NaTir
//
//  Created by David Bureš on 11.04.2023.
//

import Foundation

internal enum FileCreationError: Error
{
    case failedToCreateFile
}

func createEmptyFile(at url: URL) throws -> Void
{
    do
    {
        try "".write(to: url, atomically: true, encoding: .utf8)
    }
    catch let fileCreationError
    {
        print("Failed to create empty file: \(fileCreationError)")
    }
}
