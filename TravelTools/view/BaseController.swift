//
//  BaseController.swift
//  TravelTools
//
//  Created by Luiz Fernando dos Santos on 21/02/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//


import Foundation
import UIKit

protocol BaseController {
    func dismissKeyboard()
    func setUp()
}

class BaseViewController: UIViewController, BaseController {

    override func viewDidLoad() {
        setUp()
    }
    func setUp() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }


    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
