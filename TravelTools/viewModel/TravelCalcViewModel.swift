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
}


extension Double {
    var toString: String  {
        return String(format:"%.2f", self)
    }
}
