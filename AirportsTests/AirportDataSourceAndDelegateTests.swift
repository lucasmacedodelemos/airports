//
//  AirportDataSourceAndDelegateTests.swift
//  AirportsTests
//
//  Created by Lucas Macedo de Lemos on 17/02/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import XCTest
@testable import Airports

class AirportDataSourceAndDelegateTests: XCTestCase {

    var dataSourceAndDelegate: AirportDataSourceAndDelegate!
    
    let airports = [Airport(airportId: 667, nameAirport: "nameAirport", nameCountry: "nameCountry", codeIataAirport: "BGC", codeIso2Country: "PT")]
    
    override func setUp() {
        super.setUp()
        dataSourceAndDelegate = AirportDataSourceAndDelegate()
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
        
        dataSourceAndDelegate.data.value = airports
        
        let tableView = UITableView()
        tableView.dataSource = dataSourceAndDelegate
        
        XCTAssertEqual(dataSourceAndDelegate.tableView(tableView, numberOfRowsInSection: 0), 1)
    }
    
    func testCellType() {
        
        dataSourceAndDelegate.data.value = airports
        
        let tableView = UITableView()
        tableView.dataSource = dataSourceAndDelegate
        tableView.register(AirportTableViewCell.self, forCellReuseIdentifier: "AirportTableViewCell")

        let indexPath = IndexPath(row: 0, section: 0)
        
        guard let _ = dataSourceAndDelegate.tableView(tableView, cellForRowAt: indexPath) as? AirportTableViewCell else {
            XCTAssert(false)
            return
        }
    }
}
