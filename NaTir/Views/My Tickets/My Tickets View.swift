//
//  My Tickets View.swift
//  NaTir
//
//  Created by David Bureš on 07.04.2023.
//

import CodeScanner
import SwiftUI

struct MyTicketsView: View
{
    @EnvironmentObject var ticketsTracker: TicketsTracker

    @State var isShowingCodeScanner: Bool = false
    @State var scannedCode: String = ""

    @State private var hasLoadedTickets: Bool = false

    var body: some View
    {
        NavigationView
        {
            VStack
            {
                if !ticketsTracker.savedtickets.isEmpty
                {
                    TicketDisplayView(ticket: $ticketsTracker.savedtickets.first!)

                    #warning("IDEA: [Recent Tickets] should show only the tickets from today, while [Older Tickets] should show everything that's older than one day")
                    List
                    {
                        Section("tickets.ticket-list.section.today-tickets.title")
                        {
                            if !ticketsFromToday.dropFirst().isEmpty
                            { // Only show tickets from this day
                                ForEach(ticketsFromToday.dropFirst())
                                { ticket in
                                    OldTicketRow(ticket: ticket)
                                }
                            }
                            else
                            {
                                Text("tickets.ticket-list.section.today-tickets.no-tickets-available")
                                    .foregroundColor(.secondary)
                                    .font(.callout)
                            }
                        }

                        if !ticketsOlderThanToday.isEmpty
                        {
                            Section("tickets.ticket-list.section.old-tickets.title")
                            {
                                ForEach(ticketsOlderThanToday)
                                { oldTicket in
                                    OldTicketRow(ticket: oldTicket)
                                }
                            }
                        }
                    }
                }
                else
                {
                    VStack(alignment: .center, spacing: 20)
                    {
                        Image(systemName: "ticket")
                            .resizable()
                            .frame(width: 100)
                            .scaledToFit()
                            .foregroundColor(Color(uiColor: .lightGray))
                        VStack(alignment: .center, spacing: 2)
                        {
                            Text("tickets.ticket-list.no-tickets-added.title")
                            Text("Tap + in the top right to scan your first ticket")
                                .font(.callout)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .onAppear
            {
                // MARK: - See if we have loaded tickets before to not load them over and over

                if !hasLoadedTickets
                {
                    // MARK: - Set up the file for saving tickets

                    if FileManager.default.fileExists(atPath: AppConstants.ticketsFilePath.path)
                    {
                        print("The tickets file exists. Will try to load tickets...")

                        do
                        {
                            ticketsTracker.savedtickets = try decodeStructFromFile(fromURL: AppConstants.ticketsFilePath, typeToDecode: .Ticket) as! [Ticket]

                            hasLoadedTickets = true
                        }
                        catch let ticketsLoadingError
                        {
                            print("Failed while loading tickets from file: \(ticketsLoadingError.localizedDescription)")
                        }
                    }
                    else
                    {
                        print("The tickets file does not exist. Will create it...")

                        do
                        {
                            try createEmptyFile(at: AppConstants.ticketsFilePath)
                        }
                        catch let fileCreationError
                        {
                            print("Failed while creating empty file: \(fileCreationError.localizedDescription)")
                        }
                    }
                }
                // try! FileManager.default.removeItem(at: AppConstants.ticketsFilePath)
            }
            .onAppear
            {
                print(Date() < Date().dayAfter)
            }
            .toolbar
            {
                ToolbarItem(placement: .navigationBarTrailing)
                {
                    Button
                    {
                        isShowingCodeScanner.toggle()
                    } label: {
                        Label("action.scan-ticket", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingCodeScanner)
            {
                CodeScannerView(codeTypes: [.aztec], scanMode: .once, manualSelect: false, showViewfinder: true, shouldVibrateOnSuccess: true, isTorchOn: false)
                { response in
                    if case let .success(result) = response
                    {
                        scannedCode = result.string

                        print(scannedCode)

                        ticketsTracker.savedtickets.insert(Ticket(contents: scannedCode, dateSaved: Date()), at: 0)

                        isShowingCodeScanner.toggle()
                    }
                }
            }
        }
    }

    var ticketsFromToday: [Ticket]
    {
        let calendar = Calendar.current
        return ticketsTracker.savedtickets.filter({ calendar.isDateInToday($0.dateSaved) })
    }
    
    var ticketsOlderThanToday: [Ticket]
    {
        let calendar = Calendar.current
        return ticketsTracker.savedtickets.filter({ !calendar.isDateInToday($0.dateSaved) })
    }
}
