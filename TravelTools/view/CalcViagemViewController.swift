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
    @IBOutlet weak var declaradoSWT: UISwitch!
    @IBOutlet weak var tipoPagamento: UISegmentedControl!
    @IBOutlet weak var valorExcedenteLBL: UILabel!
    @IBOutlet weak var totalExcedenteLBL: UILabel!

    let calcViewModel = CalcViagemViewModel()


    override func viewDidLoad() {
        super.viewDidLoad()

    }


    @IBAction func calcValue(_ sender: Any) {
        guard let valor = valueTF.text, !valor.isEmpty else {
            print("Verifique o valor digitado!")
            return
        }

        if (tipoPagamento.selectedSegmentIndex == 1) {
            calcViewModel.tipoPagamento = .cartao
        } else {
            calcViewModel.tipoPagamento = .dinheiro
        }
        
        calcViewModel.setValor(valor)
        calcViewModel.declarado = declaradoSWT.isOn
        resultLBL.text = calcViewModel.getResult()
        valorExcedenteLBL.text = calcViewModel.getExcedente()
        totalExcedenteLBL.text = calcViewModel.getTotalExcedente()

    }

}

