//
//  AirportTimetableTests.swift
//  AirportsTests
//
//  Created by Lucas Macedo de Lemos on 18/02/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import XCTest
@testable import Airports

class AirportTimetableTests: XCTestCase {

    let airportTimetableDictionary: [String: Any] = ["airline":["iataCode":"BA","icaoCode":"BAW","name":"BritishAirways"],"arrival":["actualRunway":"2020-02-18T00:31:00.000","actualTime":"2020-02-18T00:57:00.000","baggage":"9","delay":nil,"estimatedRunway":"2020-02-18T00:31:00.000","estimatedTime":"2020-02-18T00:57:00.000","gate":"12","iataCode":"JFK","icaoCode":"KJFK","scheduledTime":"2020-02-18T01:15:00.000","terminal":"8"],"codeshared":["airline":["iataCode":"aa","icaoCode":"aal","name":"americanairlines"],"flight":["iataNumber":"aa184","icaoNumber":"aal184","number":"184"]],"departure":["actualRunway":"2020-02-17T17:13:00.000","actualTime":"2020-02-17T16:57:00.000","baggage":nil,"delay":nil,"estimatedRunway":"2020-02-17T17:13:00.000","estimatedTime":"2020-02-17T16:57:00.000","gate":"45","iataCode":"LAX","icaoCode":"KLAX","scheduledTime":"2020-02-17T17:00:00.000","terminal":"4"],"flight":["iataNumber":"BA4807","icaoNumber":"BAW4807","number":"4807"],"status":"landed","type":"arrival"]
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testParse() {
        
        let result = AirportTimetable.parseObject(dictionary: airportTimetableDictionary)
        
        switch result {
        case .success(let airportTimetable):
            XCTAssertNotNil(airportTimetable)
        default:
            XCTFail()
        }
    }
    
    func testErrorParse() {
        
        let result = AirportTimetable.parseObject(dictionary: [:])
        
        switch result {
        case .success(_):
            XCTFail()
        case .failure(_):
            XCTAssert(true)
        }
    }

}
