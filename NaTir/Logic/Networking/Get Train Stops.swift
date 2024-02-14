//
//  Get Train Stations.swift
//  NaTir
//
//  Created by David Bureš on 09.04.2023.
//

import Foundation
import SwiftyXMLParser

func getTrainStops(trainID: Int, date: Date) async -> [TrainStop]
{
    let requestDateFormatter: ISO8601DateFormatter = ISO8601DateFormatter()
    let formattedDate = requestDateFormatter.string(from: date)
    
    let soapPayload: String = """
    <?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <Postaje_vlaka_vse xmlns="http://www.slo-zeleznice.si/">
          <vl>\(trainID)</vl>
          <da>\(formattedDate)</da>
          <username>zeljko</username>
          <password>joksimovic</password>
        </Postaje_vlaka_vse>
      </soap:Body>
    </soap:Envelope>
    """
    
    // MARK: - Request
    
    let rawResponse = try! await sendSoapRequest(action: .getAllStopsForTrain, payloadBody: soapPayload)
    
    let parsedXML = XML.parse(rawResponse)
    
    // MARK: - Parsing of the stops
    
    let responseDateFormatter: DateFormatter = DateFormatter()
    responseDateFormatter.dateFormat = "HH:mm"
    
    var stopsTracker: [TrainStop] = .init()
    
    for stop in parsedXML["soap:Envelope", "soap:Body", "Postaje_vlaka_vseResponse", "Postaje_vlaka_vseResult", "postaje_vlaka", "Vlak", "Postaja"]
    {
        let stopName = stop["Naziv"].text!
        
        var arrivalTime: Date? = nil
        let arrivalTimeRaw = stop["Prihod"].text
        if arrivalTimeRaw != nil
        {
            arrivalTime = responseDateFormatter.date(from: arrivalTimeRaw!)
        }
        
        var departureTime: Date? = nil
        let departureTimeRaw = stop["Odhod"].text
        if departureTimeRaw != nil
        {
            departureTime = responseDateFormatter.date(from: departureTimeRaw!)
        }
        
        stopsTracker.append(TrainStop(stationName: stopName, arrivalTime: arrivalTime, departureTime: departureTime))
    }
    
    print(stopsTracker)
    
    return stopsTracker
}
