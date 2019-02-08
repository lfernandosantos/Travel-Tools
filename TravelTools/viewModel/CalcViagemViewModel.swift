//
//  CalcViagemViewModel.swift
//  TravelTools
//
//  Created by Luiz Fernando dos Santos on 07/02/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import Foundation

class CalcViagemViewModel {

    var valorPago: Double = 0.0
    var tipoPagamento: TipoPagamento = .dinheiro
    var declarado: Bool = false
    var valorExcedente: Double = 0.0


    func setValor(_ valor: String) {
        self.valorPago = Double(valor) ?? 0.0
    }


    func getResult() -> String {
        let iof = CalculoPagamento.calcIOF(valor: valorPago, tipoPagamento)
        return String(valorPago + iof)
    }


    func getExcedente() -> String {
        valorExcedente = 0.0
        if (CalculoPagamento.excedeLimite(valorPago)) {
            valorExcedente = (valorPago - 500.0)
        }
        return "\(valorExcedente)0"
    }


    func getTotalExcedente() -> String {
        var valor: Double = 0.0

        if (valorExcedente > 0.0) {
            if (declarado) {
                valor = ( valorExcedente / 2 ) + valorExcedente
            } else {
                valor = valorExcedente * 2
            }
        }

        return "\(valor)0"
    }
}
