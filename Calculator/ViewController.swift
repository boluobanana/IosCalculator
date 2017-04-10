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
    
    var brain = CalculatorBrain()

    @IBAction func appednDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if isTheFirstNumber {
            display.text = digit
            isTheFirstNumber = false
        } else {
            display.text = display.text! + digit
        }
    }
    
    @IBAction func operate(_ sender: UIButton) {
        
        if !isTheFirstNumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performeOperaion(symbol: operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    @IBAction func enter() {
        isTheFirstNumber = true;
        if let result = brain.pushOperand(operand: displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }

    var displayValue: Double {
        get {
            return (display.text! as NSString).doubleValue
        }
        set {
            display.text = "\(newValue)"
            isTheFirstNumber = true;
        }
    }
}

