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
    
    @IBAction func operate(_ sender: UIButton) {
        let operation = sender.currentTitle!
        if !isTheFirstNumber {
            enter()
        }
        switch operation {
        case "×": ferformOperation { $0 * $1 }
        case "÷": ferformOperation { $1 / $0 }
        case "+": ferformOperation { $0 + $1 }
        case "-": ferformOperation { $1 - $0 }
        default:
            break
        }
    }

    func ferformOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
        
    }
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        isTheFirstNumber = true;
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
        
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

