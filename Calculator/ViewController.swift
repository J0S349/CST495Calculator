//
//  ViewController.swift
//  Calculator
//
//  Created by Jose Sanchez-Garcia on 9/1/16.
//  Copyright © 2016 CSUMB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userInTheMiddleOfTypingNumber: Bool = false;
    
    @IBAction func appendDigit(sender: UIButton) {
        // Let is considered to be as a "const" for java or C++
        let digit = sender.currentTitle
        
        if userInTheMiddleOfTypingNumber {
            display.text = display.text! + digit!
        } else
        {
            display.text = digit!
            userInTheMiddleOfTypingNumber = true
        }
    }

    // function used to take in operation options
    @IBAction func operate(sender: UIButton) {
        let operand = sender.currentTitle
        
        if userInTheMiddleOfTypingNumber {
            Enter()
        }
        switch operand! { //need to unwrap it for it to be used like string
        case "×": performOperation {$0 * $1}
        case "÷": performOperation {$1 / $0}
        case "+": performOperation {$0 + $1}
        case "−": performOperation {$1 - $0}
        case "√": PerformOperation {sqrt($0)}
        default:
            break
        }
    }

    
    var operandStack = Array<Double>()
    @IBAction func Enter() {
        userInTheMiddleOfTypingNumber = false;
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
        
    }
    
    // This is the function that will deal with reducing our code for performing different operations
    func performOperation(operation: (Double, Double) -> Double){
        if(operandStack.count >= 2){
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            Enter()
        }
    }
    func PerformOperation(operation: Double -> Double){
        if(operandStack.count >= 1){
            displayValue = operation(operandStack.removeLast())
            Enter()
        }
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userInTheMiddleOfTypingNumber = false
        }
    }
}

