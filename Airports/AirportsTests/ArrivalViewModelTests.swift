//
//  ArrivalViewModelTests.swift
//  AirportsTests
//
//  Created by Lucas Macedo de Lemos on 18/02/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import XCTest
@testable import Airports

class ArrivalViewModelTests: XCTestCase {

    var viewModel: ArrivalViewModel!
    var dataSourceAndDelegate: GenericDataSourceAndDelegate<AirportTimetable>!
    fileprivate var service: MockAirportTimetableService!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        self.service = MockAirportTimetableService()
        self.dataSourceAndDelegate = GenericDataSourceAndDelegate<AirportTimetable>()
        self.viewModel = ArrivalViewModel(service: service, dataSourceAndDelegate: dataSourceAndDelegate)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.service = nil
        self.dataSourceAndDelegate = nil
        self.viewModel = nil
        super.tearDown()
    }

    func testFetchAirportTimetablesWithNoService() {
        
        let expectation = XCTestExpectation(description: "No airport timetables service")
        
        viewModel.service = nil
        
        viewModel.onErrorHandling = { error in
            expectation.fulfill()
        }
        
        viewModel.fetchArrivals(iataCode: "LIS")
        wait(for: [expectation], timeout: 5)
    }
    
    func testFetchAirportTimetables() {
        
        let expectation = XCTestExpectation(description: "Fetch airport timetables")
        
        service.airportTimetables = [AirportTimetable(airline: Airline(iataCode: "BA", icaoCode: "BAW", name: "British Airways"),
                                                      arrival: Arrival(scheduledTime: nil),
                                                      flight: Flight(iataNumber: "aa184", icaoNumber: "aal184", number: "184"),
                                                      status: .landed,
                                                      codeshared: nil)]
        
        viewModel.onErrorHandling = { error in
            XCTAssert(false)
        }
        
        dataSourceAndDelegate.data.addObserver(self) { _ in
            expectation.fulfill()
        }
        
        viewModel.fetchArrivals(iataCode: "BA")
        wait(for: [expectation], timeout: 5)
    }
    
    func testNoAirportTimetables() {
        
        let expectation = XCTestExpectation(description: "No airports")
        
        service.airportTimetables = nil
        
        viewModel.onErrorHandling = { error in
            expectation.fulfill()
        }
        
        viewModel.fetchArrivals(iataCode: "BA")
        wait(for: [expectation], timeout: 5)
    }
    
}

fileprivate class MockAirportTimetableService: AirportTimetableServiceProtocol {
    
    var airportTimetables: [AirportTimetable]?
    
    func fetchAirportTimetable(iataCode: String, type: String, completion: @escaping ((Result<[AirportTimetable], ErrorResult>) -> Void)) {
        if let airportTimetables = airportTimetables {
            completion(Result.success(airportTimetables))
        } else {
            completion(Result.failure(ErrorResult.custom(string: "No airport timetables")))
        }
    }
    
}
