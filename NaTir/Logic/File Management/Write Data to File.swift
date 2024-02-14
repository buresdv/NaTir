//
//  Write Data to File.swift
//  NaTir
//
//  Created by David Bureš on 11.04.2023.
//

import Foundation

internal enum FileWritingError: Error
{
    case failedToSaveToFile
}

func writeDataToFile(data: Data, fileURL: URL) throws -> Void
{
    do
    {
        try data.write(to: fileURL, options: .atomic)
    }
    catch let fileWritingError
    {
        print("Failed while saving data to file: \(fileWritingError.localizedDescription)")
        throw FileWritingError.failedToSaveToFile
    }
}
