//
//  AirportService.swift
//  AirportsTests
//
//  Created by Lucas Macedo de Lemos on 15/02/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import XCTest
@testable import Airports

class AirportServiceTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testBaseURLString() {
        
        let baseURL = URL(string: AirportService.shared.baseURLString)
        XCTAssertNotNil(baseURL)
    }
    
    func testAPIKey() {
        
        let apiKey = AirportService.shared.apiKey
        XCTAssertTrue(apiKey.count > 0)
    }

    func testCancelRequest() {
        
        AirportService.shared.fetchAirports(country: .PT) { _ in
            
        }
        
        AirportService.shared.cancelFetchAirports()
        XCTAssertNil(AirportService.shared.task, "Expected task nil")
    }
    
    func testFetchAirports() {
        
        let expectation = XCTestExpectation(description: "Fetch Portugal airports")
        
        var result: Result<[Airport], ErrorResult>? = nil
        
        AirportService.shared.fetchAirports(country: .PT) { r in
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
