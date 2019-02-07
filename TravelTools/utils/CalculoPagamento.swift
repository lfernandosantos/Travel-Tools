//
//  CalculoPagamento.swift
//  TravelTools
//
//  Created by Luiz Fernando dos Santos on 07/02/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import Foundation

enum TipoPagamento: Double {
    case dinheiro   = 1.1
    case cartao     = 6.38
}

class CalculoPagamento {

    //retorna iof em dolar
    static func calcIOF(valor: Double, tipoPagamento: TipoPagamento) -> Double {
        let iof = valor * tipoPagamento.rawValue / 100
        return iof
    }


    static func excedeLimite(_ value : Double) -> Bool {
        if value > 500 {
            return true
        }
        return false
    }
}
