//
//  ViewController.swift
//  Calculator
//
//  Created by YuTao Wu on 2016/11/27.
//  Copyright © 2016年 YuTao Wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var isTheFirstNumber: Bool = true;
    
    @IBAction func appednDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if isTheFirstNumber {
            display.text = digit
            isTheFirstNumber = false
        } else {
            display.text = display.text! + digit
        }
        
        
    }
}

