//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Jose Sanchez-Garcia on 9/8/16.
//  Copyright © 2016 CSUMB. All rights reserved.
//

import Foundation
class CalculatorBrain {
    fileprivate enum Op {
        case operand(Double)
        case unaryOperation(String, (Double) -> Double)
        case binaryOperation(String, (Double, Double) -> Double)
    }
    fileprivate var opStack = [Op]()
    
    fileprivate var knownOps = [String: Op]()
    
    // This is our initilizer for our Op
    init(){
        knownOps["×"] = Op.binaryOperation("×") {$0 * $1}
        knownOps["÷"] = Op.binaryOperation("÷") {$1 / $0}
        knownOps["+"] = Op.binaryOperation("+") {$0 + $1}
        knownOps["−"] = Op.binaryOperation("−") {$1 - $0}
        knownOps["√"] = Op.unaryOperation("√") { sqrt($0) }
        //knownOps["π"] = Op.unaryOperation("π") { M_PI }
    }
    
    fileprivate func Evaluate(_ ops: [Op]) -> (results: Double?, remainingOps: [Op]){
        if !ops.isEmpty{
            var remainingOps = ops // This gives us the ability to edit the array
            let op = remainingOps.removeLast()
            switch op {
            case .operand(let operand):
                return (operand, remainingOps)
                
            case .unaryOperation(_, let operation):
                let operandEvaluation = Evaluate(remainingOps)
                if let operand = operandEvaluation.results {
                    
                    return (operation(operand), operandEvaluation.remainingOps)
                }
            case .binaryOperation(_, let operation):
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
    
    func pushOperand(_ operand: Double) -> Double?{
        opStack.append(Op.operand(operand))
        return evaluate()
    }
    
    func performOperation(_ symbol: String) -> Double?{
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
        
    }
}
