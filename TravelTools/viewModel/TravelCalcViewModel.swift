//
//  TravelCalcViewModel.swift
//  TravelTools
//
//  Created by Luiz Fernando dos Santos on 19/02/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import Foundation


class TravelCalcViewModel {
    var iof: Double = 0.0
    var excedente: Double = 0.0
    var total: Double = 0.0
    var nDeclarado: Double = 0.0
    var declarado: Double = 0.0
}

extension TravelCalcViewModel {

    
    func calculate(value: String, paymentType: PaymentType, completion: @escaping () -> Void) {


        let paymentCalculation = PaymentCalculationModel(value: value.doubleValue,
                                                         paymentType: paymentType)
        total = paymentCalculation.getTotalValue()
        nDeclarado = paymentCalculation.getTotalNotDeclared()
        declarado = paymentCalculation.getTotalDeclared()
        excedente = paymentCalculation.getOverLimitValue()

        completion()
    }

    func getUSDBRL(completion: @escaping (String) -> Void) {
        CurrencyService().requestCurrency(endPoint: .live) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let usdBRL):
                    completion(usdBRL.toString)
                case .failure(_ ):
                    completion(0.00.toString)
                }
            }
        }
    }
}



