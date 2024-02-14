//
//  Get Route.swift
//  NaTir
//
//  Created by David Bureš on 08.04.2023.
//

import Foundation
import SwiftyXMLParser

func getRoutes(fromStation: Station, toStation: Station, date: Date, appState: AppState) async -> [Journey]
{
    let requestDateFormatter: DateFormatter = DateFormatter()
    requestDateFormatter.dateFormat = "yyyy-MM-dd"
    let formattedDate = requestDateFormatter.string(from: date)
    
    let soapPayload: String = """
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <Iskalnik_mob xmlns="http://www.slo-zeleznice.si/">
      <vs>\(fromStation.id)</vs>
      <iz>\(toStation.id)</iz>
      <vi></vi>
      <da>\(formattedDate)</da>
      <username>\(AppConstants.apiUsername)</username>
      <password>\(AppConstants.apiPassword)</password>
    </Iskalnik_mob>
  </soap:Body>
</soap:Envelope>
"""
    
    // MARK: - Request
    
    let rawResponse = try! await sendSoapRequest(action: .getRouteMoreDetail, payloadBody: soapPayload)
    
    print("Raw response: \(String(data: rawResponse, encoding: .utf8) as Any)")
    
    let parsedXML = XML.parse(rawResponse)
    
    // MARK: - Parsing of the journey
    
    let responseDateFormatter: DateFormatter = DateFormatter()
    responseDateFormatter.dateFormat = "HH:mm"
    
    let responseDayAndMonthFormatter: ISO8601DateFormatter = ISO8601DateFormatter()
    responseDayAndMonthFormatter.formatOptions = [.withFullDate]
    
    var journeyPrice: Double = 0.0
    var journeyLengthRaw: String = ""
    
    var trainTracker: [Train] = .init()
    var connectionTracker: [Journey] = .init()
    
    var journeyDelay: Delay? = nil
    
    for connection in parsedXML["soap:Envelope", "soap:Body", "Iskalnik_mobResponse", "Iskalnik_mobResult", "results", "connection"]
    {     
        journeyPrice = connection["price"].double!
        journeyLengthRaw = connection["travellingTime"].text!
        
        print("----------")
        
        print(journeyPrice)
        
        for train in connection["train"]
        {
            let trainID = train["vlak"].int
            let trainType = train["vrsta"].text
            
            let departureStationID = train["departure", "st_postaje"].int
            let departureStation: Station = appState.stations.filter({ $0.id == departureStationID }).first!
            let departureTimeRaw = train["departure", "time"].text!
            print("Will attempt to convert \(departureTimeRaw)")
            var departureTime: Date = responseDateFormatter.date(from: departureTimeRaw)!
            
            let arrivalStationID = train["arrival", "st_postaje"].int
            let arrivalStation: Station = appState.stations.filter({ $0.id == arrivalStationID }).first!
            let arrivalTimeRaw = train["arrival", "time"].text!
            print("Will attempt to convert \(arrivalTimeRaw)")
            var arrivalTime: Date = responseDateFormatter.date(from: arrivalTimeRaw)!
            
            let tripDayAndMonthRaw = train["departure", "date"].text!
            let tripDayAndMonth: Date = responseDayAndMonthFormatter.date(from: tripDayAndMonthRaw)!
            
            departureTime = combineDateWithTime(date: tripDayAndMonth, time: departureTime)!
            arrivalTime = combineDateWithTime(date: tripDayAndMonth, time: arrivalTime)!
            
            let allowsBikes = train["allowBicycle"].bool
            let hasWifi = train["WiFi"].bool
            let hasFirstClass = train["R1"].bool
        
            let delayAffectedStationRaw = train["delay", "station"].text
            print("Delay shit: \(delayAffectedStationRaw)")
            if let delayAffectedStationRaw
            {
                var delayAffectedStation = appState.stations.filter({ $0.name == delayAffectedStationRaw }).first
                    
                if delayAffectedStation == nil /// This is nil when the train is last reported in a place that doesn't have a station. If this happens, just put the name of the place without the station as the station name
                {
                    delayAffectedStation = Station(id: 000, name: delayAffectedStationRaw)
                }
                
                print("Another delay shit: \(delayAffectedStation)")
                
                let delayRaw: String = train["delay", "description"].text!
                let delayInMinutes: Int = try! Int(regexMatch(from: delayRaw, regex: "\\d{1,3}")) ?? 0
                
                journeyDelay = Delay(affectedStation: delayAffectedStation!, delayInMinutes: delayInMinutes)
            }
            
            //print(trainID)
            //print("\(departureStation) \(departureTimeRaw) --> \(arrivalStation) \(arrivalTimeRaw)")
            
            trainTracker.append(Train(id: Int(exactly: trainID!)!, type: trainType!, allowsBikes: allowsBikes!, hasWifi: hasWifi!, hasFirstClass: hasFirstClass!, travelingTime: nil, delay: journeyDelay, departureTime: departureTime, destinationArrivalTime: arrivalTime, originStation: departureStation, destinationStation: arrivalStation))
            
            journeyDelay = nil
        }
        
        //print(trainTracker)
        
        connectionTracker.append(Journey(from: fromStation, to: toStation, lengthString: journeyLengthRaw, trainsInvolved: trainTracker, price: journeyPrice))
        
        trainTracker = .init()
        
        print("----------")
    }
    
    print(connectionTracker)
    return connectionTracker
    
}
