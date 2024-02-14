//
//  Old Ticket Row.swift
//  NaTir
//
//  Created by David Bureš on 12.04.2023.
//

import SwiftUI

struct OldTicketRow: View {
    
    @State var ticket: Ticket
    @State var isShowingSheetWithOlderTicket: Bool = false
    
    @State var howOldIstheTicketText: LocalizedStringKey = ""
    
    @State var timer = Timer.publish(every: 30, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Image(systemName: "qrcode")

            VStack(alignment: .leading, spacing: 5) {
                Text(howOldIstheTicketText)
                Text(ticket.dateSaved.convertToCompleteDate())
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .onTapGesture {
            isShowingSheetWithOlderTicket.toggle()
        }
        .onReceive(timer) { _ in
            print("Executing timer...")
            howOldIstheTicketText = "tickets.ticket-item.age-\(ticket.dateSaved.timeIntervalSinceNow.convertToCustomPresentableFormat(style: .full, allowedUnits: [.day, .hour, .minute]))"
        }
        .onDisappear
        {
            print("Stopping the timer...")
            timer.upstream.connect().cancel()
        }
        .onAppear
        {
            print("Doing the first date check so the user doesn't have to wait a second for it to update...")
            howOldIstheTicketText = "tickets.ticket-item.age-\(ticket.dateSaved.timeIntervalSinceNow.convertToCustomPresentableFormat(style: .full, allowedUnits: [.day, .hour, .minute]))"
            print("Restarting the timer...")
            timer = Timer.publish(every: 30, on: .main, in: .common).autoconnect()
        }
        .sheet(isPresented: $isShowingSheetWithOlderTicket) {
            VStack(spacing: 0)
            {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(alignment: .center, spacing: 0) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("tickets.old-ticket-display.title")
                            Text(howOldIstheTicketText)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Button {
                            isShowingSheetWithOlderTicket.toggle()
                        } label: {
                            Text("action.close")
                        }
                    }
                    .padding()
                    
                    Divider()
                }
                
                TicketDisplayView(ticket: $ticket)
                
                Spacer()
            }
        }
    }
}
