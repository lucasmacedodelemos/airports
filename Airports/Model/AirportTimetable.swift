//
//  AirportTimetable.swift
//  Airports
//
//  Created by Lucas Macedo de Lemos on 18/02/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Foundation

struct AirportTimetable {
    
    enum Status: String {
        case landed
        case scheduled
        case cancelled
        case active
        case incident
        case diverted
        case redirected
        case unknown
    }
    
    let airline: Airline
    let arrival: Arrival
    let flight: Flight
    let status: Status
    let codeshared: Codeshared?
}

struct Airline {
    let iataCode: String
    let icaoCode: String
    let name: String
}

struct Arrival {
    let scheduledTime: String?
}

struct Flight {
    let iataNumber: String
    let icaoNumber: String
    let number: String
}

struct Codeshared {
    let airline: Airline
    let flight: Flight
}

extension AirportTimetable: Parceable {
    
    static func parseObject(dictionary: [String : Any]) -> Result<AirportTimetable, ErrorResult> {
        
        guard let airline = parseAirlineObject(dictionary: dictionary) else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse airline"))
        }
        
        guard let arrival = parseArrivalObject(dictionary: dictionary) else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse arrival"))
        }
        
        guard let flight = parseFlightObject(dictionary: dictionary) else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse flight"))
        }
        
        guard let status = parseStatusObject(dictionary: dictionary) else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse status"))
        }
        
        let codeshared = parseCodesharedObject(dictionary: dictionary)
                
        let airportTimetable = AirportTimetable(airline: airline, arrival: arrival, flight: flight, status: status, codeshared: codeshared)
        
        return Result.success(airportTimetable)
    }
    
    private static func parseAirlineObject(dictionary: [String: Any]) -> Airline? {
        guard let airlineDictionary = dictionary["airline"] as? [String: String],
            let airlineIataCode = airlineDictionary["iataCode"],
            let airlineIcaoCode = airlineDictionary["icaoCode"],
            let airlineName = airlineDictionary["name"] else {
            return nil
        }
        
        return Airline(iataCode: airlineIataCode, icaoCode: airlineIcaoCode, name: airlineName)
    }
    
    private static func parseArrivalObject(dictionary: [String: Any]) -> Arrival? {
        guard let arrivalDictionary = dictionary["arrival"] as? [String: Any] else {
            return nil
        }
        
        return Arrival(scheduledTime: arrivalDictionary["scheduledTime"] as? String)
    }
    
    private static func parseFlightObject(dictionary: [String: Any]) -> Flight? {
        guard let flightDictionary = dictionary["flight"] as? [String: String],
            let flightIataNumber = flightDictionary["iataNumber"],
            let flightIcaoNumber = flightDictionary["icaoNumber"],
            let flightNumber = flightDictionary["number"] else {
            return nil
        }
        
        return Flight(iataNumber: flightIataNumber, icaoNumber: flightIcaoNumber, number: flightNumber)
    }
    
    private static func parseStatusObject(dictionary: [String: Any]) -> Status? {
        
        guard let statusString = dictionary["status"] as? String else {
            return nil
        }
        
        return Status(rawValue: statusString) ?? .unknown
    }
    
    private static func parseCodesharedObject(dictionary: [String: Any]) -> Codeshared? {
        
        guard let codesharedDictionary = dictionary["codeshared"] as? [String: Any] else { return nil }
        guard let airline = parseAirlineObject(dictionary: codesharedDictionary) else { return nil }
        guard let flight = parseFlightObject(dictionary: codesharedDictionary) else { return nil }
        
        return Codeshared(airline: airline, flight: flight)
    }
}
