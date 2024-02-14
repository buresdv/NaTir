//
//  More View.swift
//  NaTir
//
//  Created by David Bureš on 07.04.2023.
//

import SwiftUI

struct MoreView: View
{
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var historyTracker: HistoryTracker
    @EnvironmentObject var favoritesTracker: FavoritesTracker
    @EnvironmentObject var ticketsTracker: TicketsTracker

    @AppStorage("maxAllowedHistoryItems") var maxAllowedHistoryItems: Int = 10

    var body: some View
    {
        NavigationView
        {
            Form
            {
                Section
                {
                    LabeledContent
                    {
                        TextField(value: $maxAllowedHistoryItems, format: .number)
                        {
                            Text("What")
                        }
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 50, alignment: .center)
                    } label: {
                        Text("Number of history items")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                Section
                {
                    Button
                    {
                        appState.isShowingHistoryResetConfirmationDialog.toggle()
                    } label: {
                        Text("Delete history")
                    }
                    .confirmationDialog("Delete All Search History?", isPresented: $appState.isShowingHistoryResetConfirmationDialog, titleVisibility: .visible)
                    {
                        Button(role: .destructive)
                        {
                            appState.isShowingHistoryResetConfirmationDialog.toggle()
                            
                            historyTracker.journeys = []
                            
                            AppConstants.hapticFeedbackGenerator.notificationOccurred(.success)
                        } label: {
                            Text("Delete History")
                        }

                        Button(role: .cancel)
                        {
                            appState.isShowingHistoryResetConfirmationDialog.toggle()
                        } label: {
                            Text("Cancel")
                        }
                    } message: {
                        Text("Your journey search history will be deleted.\nYou cannot undo this action.")
                    }

                    Button
                    {
                        appState.isShowingFavoritesResetConfirmationDialog.toggle()
                    } label: {
                        Text("Delete favorites")
                    }
                    .confirmationDialog("Delete All You Favorite Routes?", isPresented: $appState.isShowingFavoritesResetConfirmationDialog, titleVisibility: .visible)
                    {
                        Button(role: .destructive)
                        {
                            appState.isShowingFavoritesResetConfirmationDialog.toggle()
                            
                            favoritesTracker.favorites = []
                            
                            AppConstants.hapticFeedbackGenerator.notificationOccurred(.success)
                        } label: {
                            Text("Delete Favorites")
                        }

                        Button(role: .cancel)
                        {
                            appState.isShowingFavoritesResetConfirmationDialog.toggle()
                        } label: {
                            Text("Cancel")
                        }
                    } message: {
                        Text("Your favorite routes will be deleted.\nYou cannot undo this action.")
                    }

                    Button
                    {
                        appState.isShowingTicketDeletionConfirmationDialog.toggle()
                    } label: {
                        Text("Delete all tickets")
                    }
                    .confirmationDialog("Delete All Saved Tickets?", isPresented: $appState.isShowingTicketDeletionConfirmationDialog, titleVisibility: .visible)
                    {
                        Button(role: .destructive)
                        {
                            appState.isShowingTicketDeletionConfirmationDialog.toggle()
                            
                            ticketsTracker.savedtickets = []
                            
                            AppConstants.hapticFeedbackGenerator.notificationOccurred(.success)
                        } label: {
                            Text("Delete Tickets")
                        }

                        Button(role: .cancel)
                        {
                            appState.isShowingTicketDeletionConfirmationDialog.toggle()
                        } label: {
                            Text("Cancel")
                        }
                    } message: {
                        Text("All your scanned tickets will be deleted.\nYou cannot undo this action.")
                    }
                }
            }
            .navigationTitle("tab.more")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
