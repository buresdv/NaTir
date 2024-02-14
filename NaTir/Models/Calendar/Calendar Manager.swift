//
//  Calendar Manager.swift
//  NaTir
//
//  Created by David Bureš on 13.04.2023.
//

import Foundation
import EventKit
import EventKitUI
import SwiftUI

final class CalendarManager: NSObject, EKEventEditViewDelegate, ObservableObject
{    
    let eventStore: EKEventStore = EKEventStore()
    
    func addJourneyToCalendar(journey: Journey, appState: AppState) -> Void
    {
        
        eventStore.requestAccess(to: .event) { [self] success, error in
            if success && error == nil
            {
                let eventLocation: EKStructuredLocation = EKStructuredLocation(title: "Železniška postaja \(journey.trainsInvolved.first!.originStation.name)")
                eventLocation.geoLocation = CLLocation(latitude: journey.trainsInvolved.first!.originStation.coordinate!.latitude, longitude: journey.trainsInvolved.first!.originStation.coordinate!.longitude)
                eventLocation.radius = 1000
                
                let event: EKEvent = EKEvent(eventStore: self.eventStore)
                event.title = "\(journey.trainsInvolved.first!.originStation.name) → \(journey.trainsInvolved.last!.destinationStation.name)"
                event.startDate = journey.trainsInvolved.first!.departureTime
                event.endDate = journey.trainsInvolved.last!.destinationArrivalTime
                event.url = URL(string: "https://potniski.sz.si/vozni-red/?action=timetables_search&current-language=sl&departure-date=\(journey.trainsInvolved.first!.departureTime.convertToFormatForPotniskiWebsiteLinkQuery())&entry-station=\(journey.trainsInvolved.first!.originStation.id)&exit-station=\(journey.trainsInvolved.last!.destinationStation.id)")
                event.structuredLocation = eventLocation
                
                event.calendar = self.eventStore.defaultCalendarForNewEvents
                
                do
                {
                    try eventStore.save(event, span: .thisEvent)
                    AppConstants.hapticFeedbackGenerator.notificationOccurred(.success)
                } catch let eventSavingError
                {
                    DispatchQueue.main.async {
                        print("Failed to save event to calendar: \(eventSavingError.localizedDescription)")
                        AppConstants.hapticFeedbackGenerator.notificationOccurred(.warning)
                        appState.isShowingAddingEventToCalendarFailedAlert = true
                    }
                   
                }
            }
        }
    }
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        controller.dismiss(animated: true)
    }
}
