//
//  API Actions.swift
//  NaTir
//
//  Created by David Bureš on 07.04.2023.
//

import Foundation

enum APIActions: String
{
    case listAllStations = "http://www.slo-zeleznice.si/Postaje"
    case getPriceForJourney = "http://www.slo-zeleznice.si/Cene"
    case getDelays = "http://www.slo-zeleznice.si/Zamud"
    case getRoute = "http://www.slo-zeleznice.si/Iskalnik"
    case getRouteMoreDetail = "http://www.slo-zeleznice.si/Iskalnik_mob"
    case getAllStopsForTrain = "http://www.slo-zeleznice.si/Postaje_vlaka_vse"
}
