//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Jose Sanchez-Garcia on 9/8/16.
//  Copyright © 2016 CSUMB. All rights reserved.
//

import Foundation
class CalculatorBrain {
    private enum Op {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
    }
    private var opStack = [Op]()
    
    private var knownOps = [String: Op]()
    
    // This is our initilizer for our Op
    init(){
        knownOps["×"] = Op.BinaryOperation("×") {$0 * $1}
        knownOps["÷"] = Op.BinaryOperation("÷") {$1 / $0}
        knownOps["+"] = Op.BinaryOperation("+") {$0 + $1}
        knownOps["−"] = Op.BinaryOperation("−") {$1 - $0}
        knownOps["√"] = Op.UnaryOperation("√") { sqrt($0) }
    }
    
    private func Evaluate(ops: [Op]) -> (results: Double?, remainingOps: [Op]){
        if !ops.isEmpty{
            var remainingOps = ops // This gives us the ability to edit the array
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
                
            case .UnaryOperation(_, let operation):
                let operandEvaluation = Evaluate(remainingOps)
                if let operand = operandEvaluation.results {
                    
                    return (operation(operand), operandEvaluation.remainingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = Evaluate(remainingOps)
                
                if let operand1 = op1Evaluation.results {
                    
                    let op2Evaluation = Evaluate(op1Evaluation.remainingOps)
                        
                    if let operand2 = op2Evaluation.results {
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                }
            
            }
        
        }
        return (nil, ops)
    }
    
    func evaluate() -> Double? {
        let (result, remainder) = Evaluate(opStack)
        return result
    }
    
    func pushOperand(operand: Double) -> Double?{
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol: String) -> Double?{
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
        
    }
}


