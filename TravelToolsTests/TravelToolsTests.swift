//
//  TravelToolsTests.swift
//  TravelToolsTests
//
//  Created by Luiz Fernando dos Santos on 27/02/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import XCTest
@testable import TravelTools

class TravelToolsTests: XCTestCase {


    var paymentCalculation: PaymentCalculationModel!
    let value: Double = 500

    override func setUp() {
        paymentCalculation = PaymentCalculationModel(value: value, paymentType: .cash)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let expected: Double = 5.6

        XCTAssertEqual(expected, paymentCalculation.getIOF(), "Fail to calculate IOF!")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
