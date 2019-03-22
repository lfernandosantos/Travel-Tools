//
//  DetailCalcViewController.swift
//  TravelTools
//
//  Created by Luiz Fernando dos Santos on 17/03/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import UIKit

class DetailCalcViewController: BaseViewController {

    var taxType: TypeTax?
    var paymentCalculation: PaymentCalculationModel?
    var currencyType: Int = 0

    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var typePaymentLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var taxSelectedLabel: UILabel!
    @IBOutlet weak var taxSelectedValueLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let payment = paymentCalculation {
            if payment.paymentType == .cash {
                typePaymentLabel.text = "CASH"
            } else {
                typePaymentLabel.text = "CARD(Debit/Credit)"
            }

            valueLabel.text = payment.value.toString

            if let tax = taxType {
                switch tax {
                case .iof:
                    taxSelectedLabel.text = "IOF:"
                    taxSelectedValueLabel.text = payment.getIOF().toString
                    detailLabel.text = "\(payment.value) * \(payment.paymentType.rawValue) / 100"
                    descriptionLabel.text = " Value * Type of payment Tax (card/cash) / 100"
                case .overLimit:
                    if payment.isOverLimit() {
                        taxSelectedLabel.text = "Over Limit:"
                        taxSelectedValueLabel.text = payment.getOverLimitValue().toString
                        detailLabel.text = "\(payment.value) - 500"
                        descriptionLabel.text = "Value - 500(maximum allowed)"
                    }
                case .totalDeclared:
                    if payment.isOverLimit() {
                        taxSelectedLabel.text = "Total to pay:"
                        taxSelectedValueLabel.text = payment.getTotalDeclared().toString
                        detailLabel.text = "( (\(payment.value) - 500) / 2 ) + \(payment.value) + \(payment.getIOF())"
                        descriptionLabel.text = "( (Value - 500(maximum allowed)) / 2 ) Value + IOF"
                    }
                case .totalNotDeclared:
                    if payment.isOverLimit() {
                        taxSelectedLabel.text = "Total to pay:"
                        taxSelectedValueLabel.text = payment.getTotalNotDeclared().toString
                        detailLabel.text = "( \(payment.value) - 500 ) + \(payment.value) + \(payment.getIOF())"
                        descriptionLabel.text = "Value - 500(maximum allowed) + Value"
                    }
                }
            }
        }

        if currencyType == 0 {
            currencyLabel.text = "Dolar"
        } else {
            currencyLabel.text = "Real"
        }


        
    }

}
