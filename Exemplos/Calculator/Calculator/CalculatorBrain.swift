//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Pedro Henrique on 11/03/20.
//  Copyright © 2020 IESB. All rights reserved.
//

import Foundation

//struct Cadastro {
//    let nome: String
//    let telefone: String
//
//}

func somar(_ n1: Double, com n2: Double) -> Double {
    return n1 + n2
}

func subtrair(_ n1: Double, com n2: Double) -> Double {
    return n1 - n2
}

struct CalculatorBrain {
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
    private var accumulator: Double?
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    private enum Operation {
        case constant(Double)
        case unary((Double) -> Double)
        case binary((Double, Double) -> Double)
        case equals
    }
    
    private struct PendingBinaryOperation {
        let firstOperand: Double
        let function:  (Double, Double) -> Double
        
        func performWith(secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    private var operations: Dictionary<String, Operation> = [
        "+": Operation.binary(+),
        "-": Operation.binary(-),
        "V": Operation.unary(sqrt),
        "X": Operation.binary(*),
        "pi": Operation.constant(.pi),
        "=": Operation.equals
    ]
    
    
    
    private var pbo: PendingBinaryOperation?
    
    mutating func performOperation(_ mathSymbol: String) {
        let operation = operations[mathSymbol]
        switch operation {
            case .binary(let function):
                if accumulator != nil {
                    pbo = PendingBinaryOperation(
                            firstOperand: accumulator!,
                            function: function
                        )
                }
            case .unary(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .equals:
                if accumulator != nil {
                    accumulator = pbo?.performWith(secondOperand: accumulator!)
                }
            case .constant(let value): accumulator = value
            default: print("default")
            
        }
    }
    
}
