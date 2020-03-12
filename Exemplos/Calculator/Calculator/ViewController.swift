//
//  ViewController.swift
//  Calculator
//
//  Created by Pedro Henrique on 04/03/20.
//  Copyright © 2020 IESB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping = false {
        willSet {
            print("Vai entrar o valor \(newValue)")
        }
        didSet {
            print("Entrou o novo valor: \(userIsInTheMiddleOfTyping) no lugar do antigo: \(oldValue)")
        }
    }
    
    private var pendingBinaryOperation: (Double, String)!
    
    private var Brain : CalculatorBrain = CalculatorBrain() //adicionado
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    @IBAction func onDigit(_ sender: UIButton) {
        let currentValue = display.text!
        
        if userIsInTheMiddleOfTyping {
            display.text = currentValue + sender.currentTitle!
        }else {
            display.text = sender.currentTitle!
            userIsInTheMiddleOfTyping = true
        }
        
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        let operation = sender.currentTitle!
        userIsInTheMiddleOfTyping = false
        
        if operation == "=" {
            let operand = pendingBinaryOperation.0
            let op = pendingBinaryOperation.1
            
            if op == "+" {
                displayValue = operand + displayValue
            }
            
            pendingBinaryOperation = nil //null
            
        }else {
            pendingBinaryOperation = (displayValue, operation)
        }
        
    }
    
    
    

}

