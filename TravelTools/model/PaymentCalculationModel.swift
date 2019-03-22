//
//  CalculoPagamento.swift
//  TravelTools
//
//  Created by Luiz Fernando dos Santos on 07/02/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import Foundation


enum PaymentType: Double {

    case cash  = 1.1
    case card  = 6.38

    
    static func fromHashValue(hashValue: Int) -> PaymentType {
        if hashValue == 0 {
            return .cash
        } else {
            return .card
        }
    }
}


class PaymentCalculationModel {

    let value: Double
    let valueLimit: Double = 500.0
    let paymentType: PaymentType


    init(value: Double, paymentType: PaymentType) {
        self.value = value
        self.paymentType = paymentType
    }


    func getIOF() -> Double {
        let iof = value * paymentType.rawValue / 100
        return iof
    }


    func getTotalValue() -> Double {
         return value + getIOF()
    }


    func getTotalNotDeclared() -> Double {
        return getTotalValue() + getOverLimitValue()
    }


    func getTotalDeclared() -> Double {
        return (getTotalValue() + ((getOverLimitValue() / 2)))
    }


    func getOverLimitValue() -> Double {
        if isOverLimit(){
            return value - valueLimit
        }

        return 0.0
    }


    func isOverLimit() -> Bool {
        if value > valueLimit {
            return true
        }
        return false
    }

}

enum TypeTax {
    case iof, overLimit, totalDeclared, totalNotDeclared
}
