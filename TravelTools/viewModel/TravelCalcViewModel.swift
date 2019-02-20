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

//    init(iof: Double, excedente: Double, total: Double, nDeclarado: Double, declarado: Double) {
//        self.iof = iof
//        self.excedente = excedente
//        self.total = total
//        self.nDeclarado = nDeclarado
//        self.declarado = declarado
//    }
}

extension TravelCalcViewModel {

    
    func calculate(value: String, tipoPagamento: TipoPagamento, completion: @escaping () -> Void) {
        if let dValue = Double(value) {

            self.iof = CalculoPagamento.calcIOF(valor: dValue, tipoPagamento)

            if (CalculoPagamento.excedeLimite(dValue)) {
                excedente = (dValue - 500.0)
            }
            total = dValue + iof
            nDeclarado = (total + excedente)
            declarado = (total + (excedente / 2))
        }
        completion()
    }
}


extension Double {
    var toString: String  {
        return String(format:"%.2f", self)
    }
}
