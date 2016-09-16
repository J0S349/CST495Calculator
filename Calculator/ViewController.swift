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
    @IBOutlet weak var history: UILabel!
    
    var userInTheMiddleOfTypingNumber: Bool = false
    
    @IBAction func appendDigit(_ sender: UIButton) {
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
    // This is connection between controller and model
    //var brain = CalculatorBrain()
    /*
    @IBAction func appendDigit(_ sender: UIButton) {
     
     
    }
*/
    let x = M_PI // Value of Pi

    @IBAction func Pi(_ sender: UIButton) {

        userInTheMiddleOfTypingNumber = true
        history.text = history.text! + ", π"
        
        if display.text != "0" {
            Enter() // Push the current value into the stack
            display.text = "\(x)" //set the label to pie (actual value)
            Enter() // now push it into the stack
        }
        else {
            display.text = "\(x)" // set the label to pie
            Enter() // push into stack
        }
        
    }
    
    // This function will be used to reset the contents of the display
    // label and empty the stack.
    @IBAction func clear(_ sender: UIButton) {
        display.text = "0"
        operandStack.removeAll()
        userInTheMiddleOfTypingNumber = false
        history.text = ""
        counter = 1
    }

    // Create a variable that will keep track of when the
    // user pressed this button
    var dotPressed: Bool = false
    @IBAction func dot(_ sender: UIButton) {
        userInTheMiddleOfTypingNumber = true
        // Check whether the button was pressed already
        if dotPressed == false
        {
            display.text = display.text! + "."
            dotPressed = true
        }
    }
    
    // function used to take in operation options

    @IBAction func operate(_ sender: UIButton) {
        if userInTheMiddleOfTypingNumber {
            Enter()
        }
        let operation = sender.currentTitle!
        
        history.text = history.text! + ", " + operation
        // Switch function for operation
        switch operation {
        case "×": performOperation {$0 * $1}
        case "÷": performOperation {$1 / $0}
        case "+": performOperation {$0 + $1}
        case "−": performOperation {$1 - $0}
        case "√": PerformOperation {sqrt($0) }
        case "sin": PerformOperation { sin($0) }
        case "cos": PerformOperation { cos($0) }
        
        default: break;
        }
    }
    
    // function to perform operation with two parameters
    func performOperation(operation: (Double, Double) -> Double)
    {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            
            //history.text = display.text! + ", " + history.text!
            Enter()
        }
    }

    func PerformOperation(operation: (Double) -> Double){
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            Enter()
        }
    }
    var counter = 1
    // Creating a function for when they enter PerformOperation
    @IBAction func Enter() {
        userInTheMiddleOfTypingNumber = false;
        
        print(operandStack)
        if counter == 1
        {
            history.text = display.text!
            counter = counter + 1
        }
        else
        {
            history.text = display.text! + ", " + history.text!
        }
        // Make sure we reset back the dotPressed function to false
        dotPressed = false
        // Push value into the operandStack
        operandStack.append(displayValue)
        //brain.pushOperand(displayValue)

    }
    
    
    var operandStack = Array<Double>()
    var displayValue: Double {
        get {
            return NumberFormatter().number(from: display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userInTheMiddleOfTypingNumber = false
        }
    }
    
}

