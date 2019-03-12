//
//  PaymentCalculationTests.swift
//  TravelToolsTests
//
//  Created by Luiz Fernando dos Santos on 28/02/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import XCTest
@testable import TravelTools


class PaymentIofCalculationTests: XCTestCase {


    var paymentCalculation: PaymentCalculationModel!


    override func setUp() {
        print("Start tests")
    }

    override func tearDown() {

        print("Finish tests")
    }

    func testIOFZeroValueCash() {
        paymentCalculation = PaymentCalculationModel(value: 0.0, paymentType: .cash)
        XCTAssertEqual(paymentCalculation.getIOF(), 0, "Error to get IOF from 0 value.")
    }

    func testIOFMinValueCash() {
        paymentCalculation = PaymentCalculationModel(value: 1, paymentType: .cash)
        XCTAssertEqual(paymentCalculation.getIOF(), 0.011, "Error to get IOF from minimum.")
    }

    func testIOFCash() {
        paymentCalculation = PaymentCalculationModel(value: 8000.0, paymentType: .cash)
        XCTAssertEqual(paymentCalculation.getIOF(), 88, "Error to get IOF.")
    }

    func testIOFZeroValueCard() {
        paymentCalculation = PaymentCalculationModel(value: 0.0, paymentType: .card)
        XCTAssertEqual(paymentCalculation.getIOF(), 0, "Error to get IOF from value 0.")
    }

    func testIOFMinValueCard() {
        paymentCalculation = PaymentCalculationModel(value: 1, paymentType: .card)
        XCTAssertEqual(paymentCalculation.getIOF(), 0.0638, "Error to get IOF from minimum value.")
    }

    func testIOFCashCard() {
        paymentCalculation = PaymentCalculationModel(value: 8000.0, paymentType: .card)
        XCTAssertEqual(paymentCalculation.getIOF(), 510.4, "Error to get IOF.")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
