//
//  ArrivalDataSourceAndDelegateTests.swift
//  AirportsTests
//
//  Created by Lucas Macedo de Lemos on 18/02/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import XCTest
@testable import Airports

class ArrivalDataSourceAndDelegateTests: XCTestCase {

    var dataSourceAndDelegate: ArrivalDataSourceAndDelegate!
    
    let airportTimetables = [AirportTimetable(airline: Airline(iataCode: "BA", icaoCode: "BAW", name: "British Airways"),
                                              arrival: Arrival(scheduledTime: nil),
                                              flight: Flight(iataNumber: "aa184", icaoNumber: "aal184", number: "184"),
                                              status: .landed,
                                              codeshared: nil)]
    
    override func setUp() {
        super.setUp()
        dataSourceAndDelegate = ArrivalDataSourceAndDelegate()
    }

    override func tearDown() {
        dataSourceAndDelegate = nil
        super.tearDown()
    }

    func testEmptyValue() {
        
        dataSourceAndDelegate.data.value = []
        
        let tableView = UITableView()
        tableView.dataSource = dataSourceAndDelegate
        
        XCTAssertEqual(dataSourceAndDelegate.tableView(tableView, numberOfRowsInSection: 0), 0)
    }
    
    func testWithValue() {
        
        dataSourceAndDelegate.data.value = airportTimetables
        
        let tableView = UITableView()
        tableView.dataSource = dataSourceAndDelegate
        
        XCTAssertEqual(dataSourceAndDelegate.tableView(tableView, numberOfRowsInSection: 0), 1)
    }
    
    func testCellType() {
        
        dataSourceAndDelegate.data.value = airportTimetables
        
        let tableView = UITableView()
        tableView.dataSource = dataSourceAndDelegate
        tableView.register(ArrivalTableViewCell.self, forCellReuseIdentifier: "ArrivalTableViewCell")

        let indexPath = IndexPath(row: 0, section: 0)
        
        guard let _ = dataSourceAndDelegate.tableView(tableView, cellForRowAt: indexPath) as? ArrivalTableViewCell else {
            XCTAssert(false)
            return
        }
    }

}
