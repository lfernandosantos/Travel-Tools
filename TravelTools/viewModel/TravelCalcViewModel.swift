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

    
    func calculate(value: String, tipoPagamento: TipoPagamento, completion: @escaping () -> Void) {

        self.iof = CalculoPagamento.calcIOF(valor: value.doubleValue, tipoPagamento)

        if (CalculoPagamento.excedeLimite(value.doubleValue)) {
            excedente = (value.doubleValue - 500.0)
        }
        total = value.doubleValue + iof
        nDeclarado = (total + excedente)
        declarado = (total + (excedente / 2))

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



