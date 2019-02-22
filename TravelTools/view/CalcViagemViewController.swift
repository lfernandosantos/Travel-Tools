//
//  ViewController.swift
//  TravelTools
//
//  Created by Luiz Fernando dos Santos on 07/02/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import UIKit

class CalcViagemViewController: BaseViewController {

    @IBOutlet weak var stackTax: UIStackView!
    @IBOutlet weak var iofLBL: UILabel!
    @IBOutlet weak var excedenteLBL: UILabel!
    @IBOutlet weak var totalDeclaradoLBL: UILabel!
    @IBOutlet weak var totalNdeclaradoCTxLBL: UILabel!
    @IBOutlet weak var valorTotalLBL: UILabel!
    @IBOutlet weak var taxaCambioTF: UITextField!
    @IBOutlet weak var valueTF: UITextField!
    @IBOutlet weak var tipoPagamento: UISegmentedControl!

    @IBOutlet weak var tipoMoedaSegControl: PaymentSegControl!

    var taxCambio: Double = 0.0
    var amtValue: Int = 0
    var amtTx: Int = 0

    var travalCalcViewModel = TravelCalcViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        tipoMoedaSegControl.segDelegate = self
        tipoPagamento.addTarget(self, action: #selector(self.calcValue(_:)), for: UIControl.Event.valueChanged)
        stackTax.addBackground(color: .orange)

        tipoMoedaSegControl.setBounds(superView: self.view)
        valueTF.delegate = self
        valueTF.placeholder = updateAmount(0)
        taxaCambioTF.delegate = self
        taxaCambioTF.placeholder = updateAmount(1)
    }


    @IBAction func convertValue(_ sender: Any) {
        if let text = taxaCambioTF.text {
            if text.doubleValue > 0 {
                taxCambio = text.doubleValue
                tipoMoedaSegControl.segmentControl.selectedSegmentIndex = 1
                tipoMoedaSegControl.updateSegBar()
                calcTravel()
            }
        }
    }


    @IBAction func calcValue(_ sender: Any) {
        calcTravel()
    }


    func calcTravel() {

        let tpPagamento = TipoPagamento.fromHashValue(hashValue: tipoPagamento.selectedSegmentIndex)

        guard let valor = valueTF.text, !valor.isEmpty else {
            print("Verifique o valor digitado!")
            return
        }

        travalCalcViewModel.calculate(value: valor, tipoPagamento: tpPagamento) {

            if self.tipoMoedaSegControl.segmentControl.selectedSegmentIndex == 0 {

                self.iofLBL.text = self.travalCalcViewModel.iof.toString
                self.excedenteLBL.text = self.travalCalcViewModel.excedente.toString
                self.totalDeclaradoLBL.text = self.travalCalcViewModel.declarado.toString
                self.totalNdeclaradoCTxLBL.text = self.travalCalcViewModel.nDeclarado.toString
                self.valorTotalLBL.text = self.travalCalcViewModel.total.toString

            } else {

                self.iofLBL.text = (self.travalCalcViewModel.iof * self.taxCambio).toString
                self.excedenteLBL.text = (self.travalCalcViewModel.excedente * self.taxCambio).toString
                self.totalDeclaradoLBL.text = (self.travalCalcViewModel.declarado * self.taxCambio).toString
                self.totalNdeclaradoCTxLBL.text = (self.travalCalcViewModel.nDeclarado * self.taxCambio).toString
                self.valorTotalLBL.text = (self.travalCalcViewModel.total * self.taxCambio).toString
            }
        }
    }
}

extension CalcViagemViewController: MoedaSegControlDelegate {
    func segPressed(id: Int, title: String?) {
        calcTravel()
    }
}

extension CalcViagemViewController: UITextFieldDelegate {


    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == taxaCambioTF {
            if let text = taxaCambioTF.text {
                if text.doubleValue > 0 {
                    taxCambio = text.doubleValue
                    tipoMoedaSegControl.segmentControl.selectedSegmentIndex = 1
                    tipoMoedaSegControl.updateSegBar()

                }
            }
        }

        calcTravel()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if textField == valueTF {

            if let digit = Int(string) {
                amtValue = amtValue * 10 + digit
                textField.text = updateAmount(0)
            }

            if string == "" {
                amtValue = amtValue/10
                textField.text = updateAmount(0)
            }
        } else {
            if let digit = Int(string) {
                amtTx = amtTx * 10 + digit
                textField.text = updateAmount(1)
            }

            if string == "" {
                amtTx = amtTx/10
                textField.text = updateAmount(1)
            }
        }

        return false
    }


    func updateAmount(_ id: Int) -> String? {


        let formatter  = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        formatter.currencyCode = "$"

        var amount: Double = 0.0
        if id == 0 {
            amount = Double(amtValue/100) + Double(amtValue%100)/100
        } else {
            amount = Double(amtTx/100) + Double(amtTx%100)/100
        }

        return formatter.string(from: NSNumber(value: amount))

    }
}
