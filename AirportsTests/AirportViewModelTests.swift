//
//  AirportViewModelTests.swift
//  AirportsTests
//
//  Created by Lucas Macedo de Lemos on 15/02/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import XCTest
@testable import Airports

class AirportViewModelTests: XCTestCase {

    var viewModel: AirportViewModel!
    var dataSourceAndDelegate: GenericDataSourceAndDelegate<Airport>!
    fileprivate var service: MockAirportService!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        self.service = MockAirportService()
        self.dataSourceAndDelegate = GenericDataSourceAndDelegate<Airport>()
        self.viewModel = AirportViewModel(service: service, dataSourceAndDelegate: dataSourceAndDelegate)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.service = nil
        self.dataSourceAndDelegate = nil
        self.viewModel = nil
        super.tearDown()
    }

    func testFetchAirportsWithNoService() {
        
        let expectation = XCTestExpectation(description: "No airport service")
        
        viewModel.service = nil
        
        viewModel.onErrorHandling = { error in
            expectation.fulfill()
        }
        
        viewModel.fetchAirports()
        wait(for: [expectation], timeout: 5)
    }
    
    func testFetchAirports() {
        
        let expectation = XCTestExpectation(description: "Fetch airports")
        
        service.airports = [Airport(airportId: 667, nameAirport: "nameAirport", codeIataAirport: "BGC", codeIso2Country: "PT")]
        
        viewModel.onErrorHandling = { error in
            XCTAssert(false)
        }
        
        dataSourceAndDelegate.data.addObserver(self) { _ in
            expectation.fulfill()
        }
        
        viewModel.fetchAirports()
        wait(for: [expectation], timeout: 5)
    }
    
    func testNoAirports() {
        
        let expectation = XCTestExpectation(description: "No airports")
        
        service.airports = nil
        
        viewModel.onErrorHandling = { error in
            expectation.fulfill()
        }
        
        viewModel.fetchAirports()
        wait(for: [expectation], timeout: 5)
    }

}

fileprivate class MockAirportService: AirportServiceProtocol {
    var airports: [Airport]?
    
    func fetchAirports(country: Country, completion: @escaping ((Result<[Airport], ErrorResult>) -> Void)) {
        
        if let airports = airports {
            completion(Result.success(airports))
        } else {
            completion(Result.failure(ErrorResult.custom(string: "No airports")))
        }
    }
    
}
