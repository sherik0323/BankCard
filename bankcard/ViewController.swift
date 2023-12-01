//
//  ViewController.swift
//  bankcard
//
//  Created by Sherozbek on 23/11/23.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var builder = {
        return ViewBuilder(controller: self, view: view)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#141414FF")
        builder.setPageTitle(title: "Design your virtual card")
        builder.getCard()
        builder.getColorSlider()
        builder.setIconSlider()
        builder.setDescriptionText()
        builder.addContinueButton()
    }


}

