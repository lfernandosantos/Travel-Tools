//
//  ViewController.swift
//  TravelTools
//
//  Created by Luiz Fernando dos Santos on 07/02/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import UIKit

class CalcViagemViewController: UIViewController {


    @IBOutlet weak var valueTF: UITextField!
    @IBOutlet weak var calcBTN: UIButton!
    @IBOutlet weak var resultLBL: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func calcValue(_ sender: Any) {
        guard let valor = valueTF.text, !valor.isEmpty, let doubleValue = Double(valueTF.text!) else {
            print("Verifique o valor digitado!")
            return
        }

        let iof = CalculoPagamento.calcIOF(valor: doubleValue , tipoPagamento: .dinheiro)
        let resultado = doubleValue + iof
        resultLBL.text = "\(resultado)"
    }

}

