//
//  App State.swift
//  NaTir
//
//  Created by David Bureš on 07.04.2023.
//

import Foundation

class AppState: ObservableObject
{
    @Published var isLoadingStations: Bool = false
    
    @Published var isShowingAddingEventToCalendarFailedAlert: Bool = false
    @Published var hasSuccessfullyAddedJourneyToCalendar: Bool = false
    
    @Published var isShowingHistoryResetConfirmationDialog: Bool = false
    @Published var isShowingFavoritesResetConfirmationDialog: Bool = false
    @Published var isShowingTicketDeletionConfirmationDialog: Bool = false
    
    @Published var stations: [Station] = .init()
}
