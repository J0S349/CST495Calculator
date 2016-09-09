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
    
    // This is connection between controller and model
    var brain = CalculatorBrain()
    
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
        if userInTheMiddleOfTypingNumber {
            Enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation){
                displayValue = result
            }
            else{
                displayValue = 0
            }
        }
    }

    @IBAction func Enter() {
        userInTheMiddleOfTypingNumber = false;
        brain.pushOperand(displayValue)
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

