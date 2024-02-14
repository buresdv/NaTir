//
//  ContentView.swift
//  NaTir
//
//  Created by David Bureš on 07.04.2023.
//

import SwiftUI

struct ContentView: View
{
    @StateObject var calendarManager = CalendarManager()
    
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var locationManager: LocationManager
    
    @EnvironmentObject var favoritesTracker: FavoritesTracker
    @EnvironmentObject var historyTracker: HistoryTracker
    @EnvironmentObject var ticketsTracker: TicketsTracker
    
    var body: some View
    {
        TabView {
            ConnectionsView(favoritesTracker: favoritesTracker, historyTracker: historyTracker)
                .tabItem {
                    Label("tab.connections", systemImage: "magnifyingglass")
                }
            
            MyTicketsView()
                .tabItem {
                    Label("tab.my-tickets", systemImage: "ticket")
                }
            
            StationsView()
                .tabItem {
                    Label("tab.stations", systemImage: "train.side.front.car")
                }
            
            MoreView()
                .tabItem {
                    Label("tab.more", systemImage: "ellipsis")
                }
        }
        .environmentObject(calendarManager)
        .task(priority: .background)
        {
            appState.stations = await getStations()
        }
        .onAppear
        {
            locationManager.checkIfLocationServicesEnabled()
        }
    }
}
