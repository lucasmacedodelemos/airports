//
//  AirportTimetableServiceTests.swift
//  AirportsTests
//
//  Created by Lucas Macedo de Lemos on 18/02/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import XCTest
@testable import Airports

class AirportTimetableServiceTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testBaseURLString() {
        
        let baseURL = URL(string: AirportTimetableService.shared.baseURLString)
        XCTAssertNotNil(baseURL)
    }
    
    func testAPIKey() {
        
        let apiKey = AirportTimetableService.shared.apiKey
        XCTAssertTrue(apiKey.count > 0)
    }
    
    func testCancelRequest() {
        
        AirportTimetableService.shared.fetchAirportTimetable(iataCode: "LIS", type: "arrival") { _ in
            
        }
        
        AirportTimetableService.shared.cancelFetchAirportTimetable()
        XCTAssertNil(AirportTimetableService.shared.task, "Expected task nil")
    }
    
    func testFetchAirportTimetable() {
        
        let expectation = XCTestExpectation(description: "Fetch Lisboa airport timetable")
        
        var result: Result<[AirportTimetable], ErrorResult>? = nil
        
        AirportTimetableService.shared.fetchAirportTimetable(iataCode: "LIS", type: "arrival") { r in
            result = r
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
        switch result {
        case .success(let airports):
            XCTAssertNotNil(airports)
        default:
            XCTFail()
        }
    }
}
