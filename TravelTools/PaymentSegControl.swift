//
//  PaymentSegControl.swift
//  TravelTools
//
//  Created by Luiz Fernando dos Santos on 17/02/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import Foundation
import UIKit

protocol MoedaSegControlDelegate {
    func segPressed(id: Int, title: String?)
}


protocol SegueControlProtocol {
    var segDelegate: MoedaSegControlDelegate? { get set }
}


class PaymentSegControl: UIView, SegueControlProtocol {

    var segDelegate: MoedaSegControlDelegate?
    @IBOutlet weak var segmentControl: UISegmentedControl!
    var buttonBar = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInitialization()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInitialization()
    }


    func commonInitialization() {
        let view = Bundle.main.loadNibNamed("PaymentSegControl", owner: self, options: nil)!.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
        updateConstraints()
        layoutIfNeeded()
        

        segmentControl.removeAllSegments()
        insertSegment(index: 0, title: "Dolar")
        insertSegment(index: 1, title: "Real")

        segmentControl.selectedSegmentIndex = 0

        setBottomBar()

        segmentControl.addTarget(self, action: #selector(self.segmentedControlValueChanged(_:)), for: UIControl.Event.valueChanged)

    }


    func setBottomBar() {
        segmentControl.backgroundColor = .clear
        segmentControl.tintColor = .clear

        segmentControl.setTitleTextAttributes(
            [NSAttributedString.Key.font : UIFont(name: "DINCondensed-Bold", size: 18),
             NSAttributedString.Key.foregroundColor: UIColor.lightGray ], for: .normal)

        segmentControl.setTitleTextAttributes(
            [NSAttributedString.Key.font : UIFont(name: "DINCondensed-Bold", size: 18),
             NSAttributedString.Key.foregroundColor: UIColor.orange ], for: .selected)


        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.backgroundColor = .black
        self.addSubview(buttonBar)

        buttonBar.topAnchor.constraint(equalTo: segmentControl.bottomAnchor).isActive = true
        buttonBar.heightAnchor.constraint(equalToConstant: 2).isActive = true
        buttonBar.leftAnchor.constraint(equalTo: segmentControl.leftAnchor).isActive = true
        buttonBar.widthAnchor.constraint(equalTo: segmentControl.widthAnchor, multiplier: 1 / CGFloat(segmentControl.numberOfSegments)).isActive = true
    }


    func insertSegment(index: Int, title: String) {
        segmentControl.insertSegment(withTitle: title, at: index, animated: true)
    }

    func updateSegBar() {
        UIView.animate(withDuration: 0.3) {
            self.buttonBar.frame.origin.x = (self.segmentControl.frame.width / CGFloat(self.segmentControl.numberOfSegments)) * CGFloat(self.segmentControl.selectedSegmentIndex)

            self.segDelegate?.segPressed(id: self.segmentControl.selectedSegmentIndex, title: self.segmentControl.titleForSegment(at: self.segmentControl.selectedSegmentIndex))

        }
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        updateSegBar()
    }
}
