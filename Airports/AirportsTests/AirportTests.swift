//
//  AirportsTests.swift
//  AirportsTests
//
//  Created by Lucas Macedo de Lemos on 15/02/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import XCTest
@testable import Airports

class AirportTests: XCTestCase {

    let airportJSON: [String : Any] = ["airportId": 667,
                                       "codeIataAirport": "BGC",
                                       "codeIso2Country": "PT",
                                       "nameAirport": "Braganca",
                                       "nameCountry": "Portugal"]
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testParse() {
        
        let result = Airport.parseObject(dictionary: airportJSON)
        
        switch result {
        case .success(let converter):
            XCTAssertEqual(converter.nameAirport, airportJSON["nameAirport"] as! String)
        default:
            XCTFail()
        }
    }
    
    func testErrorParse() {
        
        let result = Airport.parseObject(dictionary: [:])
        
        switch result {
        case .success(_):
            XCTFail()
        case .failure(_):
            XCTAssert(true)
        }
    }
}
