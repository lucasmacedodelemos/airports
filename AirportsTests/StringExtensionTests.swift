//
//  StringExtensionTests.swift
//  AirportsTests
//
//  Created by Lucas Macedo de Lemos on 18/02/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import XCTest
@testable import Airports

class StringExtensionTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testStrinToDate() {
        let stringDate = "2020-02-18T01:15:00.000"
        let date = stringDate.toDate
        
        XCTAssertNotNil(date)
    }

}
