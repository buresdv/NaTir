//
//  NaTirApp.swift
//  NaTir
//
//  Created by David Bureš on 07.04.2023.
//

import SwiftUI

@main
struct NaTirApp: App
{
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @StateObject var locationManager = LocationManager()

    @StateObject var favoritesTracker = FavoritesTracker()
    @StateObject var historyTracker = HistoryTracker()
    @StateObject var ticketsTracker = TicketsTracker()
    

    var body: some Scene
    {
        WindowGroup
        {
            ContentView()
                .environmentObject(appDelegate.appState)
                .environmentObject(favoritesTracker)
                .environmentObject(historyTracker)
                .environmentObject(locationManager)
                .environmentObject(ticketsTracker)
                .onChange(of: favoritesTracker.favorites)
                { newValue in
                    print("Favorites tracker changed: \(newValue)")

                    // MARK: - Saving of favorites into a file

                    do
                    {
                        let encodedFavorites: Data = try encodeForSaving(object: newValue)

                        do
                        {
                            try writeDataToFile(data: encodedFavorites, fileURL: AppConstants.favoritesFilePath)
                        }
                        catch let writingError
                        {
                            print("Error while saving favorites: \(writingError.localizedDescription)")
                        }
                    }
                    catch let encodingError
                    {
                        print("Error while encoding file: \(encodingError.localizedDescription)")
                    }
                }
                .onChange(of: historyTracker.journeys)
                { newValue in
                    print("History tracker changed: \(newValue)")

                    // MARK: - Saving of history into a file
                    do
                    {
                        let encodedHistory: Data = try encodeForSaving(object: newValue)

                        do
                        {
                            try writeDataToFile(data: encodedHistory, fileURL: AppConstants.historyFilePath)
                        }
                        catch let writingError
                        {
                            print("Error while saving history: \(writingError.localizedDescription)")
                        }
                    }
                    catch let encodingError
                    {
                        print("Error while encoding file: \(encodingError.localizedDescription)")
                    }
                }
                .onChange(of: ticketsTracker.savedtickets, perform: { newValue in
                    print("Ticket tracker changed: \(newValue)")
                    
                    // MARK: - Saving of tickets into a file
                    do
                    {
                        let encodedTickets: Data = try encodeForSaving(object: newValue)
                        
                        do
                        {
                            try writeDataToFile(data: encodedTickets, fileURL: AppConstants.ticketsFilePath)
                        }
                        catch let writingError
                        {
                            print("Error while saving history: \(writingError.localizedDescription)")
                        }
                    }
                    catch let encodingError
                    {
                        print("Error while encoding file: \(encodingError.localizedDescription)")
                    }
                })
                .onAppear
                {
                    // MARK: - Loading of favorites from file
                    print(AppConstants.favoritesFilePath.path)
                    if FileManager.default.fileExists(atPath: AppConstants.favoritesFilePath.path)
                    {
                        print("Favorites file exists, will attempt to load up favorites")

                        do
                        {
                            favoritesTracker.favorites = try decodeStructFromFile(fromURL: AppConstants.favoritesFilePath, typeToDecode: .Journey) as! [Journey]
                        }
                        catch let favoritesLoadingError
                        {
                            print("Failed while loading favorites: \(favoritesLoadingError)")
                        }
                    }
                    else
                    {
                        print("Favorites file does not exist at \(AppConstants.favoritesFilePath.path)")

                        do
                        {
                            try createEmptyFile(at: AppConstants.favoritesFilePath)
                        }
                        catch
                        {
                            print(error.localizedDescription)
                        }
                    }

                    // MARK: - Loading of history from file

                    print(AppConstants.historyFilePath.path)
                    if FileManager.default.fileExists(atPath: AppConstants.historyFilePath.path)
                    {
                        print("History file exists, will attempt to load up history")

                        do
                        {
                            historyTracker.journeys = try decodeStructFromFile(fromURL: AppConstants.historyFilePath, typeToDecode: .Journey) as! [Journey]
                        }
                        catch let favoritesLoadingError
                        {
                            print("Failed while loading history: \(favoritesLoadingError)")
                        }
                    }
                    else
                    {
                        print("History file does not exist at \(AppConstants.historyFilePath.path)")

                        do
                        {
                            try createEmptyFile(at: AppConstants.historyFilePath)
                        }
                        catch
                        {
                            print(error.localizedDescription)
                        }
                    }
                }
        }
    }
}
