//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by YuTao Wu on 2017/4/7.
//  Copyright © 2017年 YuTao Wu. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private enum Op: CustomStringConvertible{
        case Operand(Double)
        case UnaryOperation(String, (Double) -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        
        var description: String {
            get {
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                }
            }
        }
    }
    
    private var opStack = [Op]()
    
    private var knowOps = [String: Op]()
    
    init () {
        knowOps["×"] = Op.BinaryOperation("×", *)
        knowOps["÷"] = Op.BinaryOperation("÷") {$1 / $0}
        knowOps["+"] = Op.BinaryOperation("+", +)
        knowOps["-"] = Op.BinaryOperation("-") {$1 - $0}
        knowOps["√"] = Op.UnaryOperation("√", sqrt)
    }
    
   private func evaluate(ops: [Op]) -> (result: Double?, reminingOps: [Op]) {
    
        if !ops.isEmpty {
            var reminingOps = ops
            let op = reminingOps.removeLast()
            
            switch op {
            case .Operand(let operand):
                return (operand, reminingOps)
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(ops: reminingOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand), operandEvaluation.reminingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(ops: reminingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(ops: reminingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1, operand2), op2Evaluation.reminingOps)
                    }
                }
            }
        }
        return (nil, ops)
    }
    
    func evaluate() -> Double?  {
        let (result, remainder) = evaluate(ops: opStack)
        print("\(opStack) = \(String(describing: result)) with \(remainder) left over")
        return result
    }
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performeOperaion(symbol: String) -> Double? {
        if let operation = knowOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }
}
