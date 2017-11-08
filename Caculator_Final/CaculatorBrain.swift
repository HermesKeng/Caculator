//
//  CaculatorBrain.swift
//  Caculator_Final
//
//  Created by 耿楷寗 on 16/10/2017.
//  Copyright © 2017 EIE. All rights reserved.
//

import Foundation


struct CaculatorBrain{
    
    private var accumlator:Double?
    private var multiplexer :Double?
    private var operations:Dictionary<String,Operation>=[
        "π":Operation.constant(round(Double.pi*1000000000)/1000000000),
        "e":Operation.constant(round(M_E*1000000000)/1000000000),
        "+":Operation.binaryOperation({$0+$1}),
        "-":Operation.binaryOperation({$0-$1}),
        "x":Operation.binaryOperation({$0*$1}),
        "÷":Operation.binaryOperation({$0/$1}),
        "tan":Operation.unaryOperation({tan($0)}),
        "cos":Operation.unaryOperation({cos($0)}),
        "sin":Operation.unaryOperation({sin($0)}),
        "√":Operation.unaryOperation({sqrt($0)}),
        "%":Operation.unaryOperation({$0/100}),
        "+/-":Operation.specialOperation({-$0}),
        "=":Operation.equals
    ]
    private struct PendingBinaryOperation{
        let function:(Double,Double)->Double
        let firstOperand:Double
        
        func perform(with secondOperand:Double) -> Double {
            return function(firstOperand,secondOperand)
        }
    }
    private var pendingBinaryOperation:PendingBinaryOperation?
    private var pendingMultiplexerOperation:PendingBinaryOperation?
    private enum Operation{
        case constant(Double)
        case binaryOperation((Double,Double)->Double)
        case unaryOperation((Double)->Double)
        case specialOperation((Double)->Double)
        case equals
    }
    mutating func performOperation(_symbol:String){
        if let operation=operations[_symbol]{
            
            switch operation{
            case .constant(let value):
                accumlator=value
            case .binaryOperation(let function):
                if accumlator != nil {
                    switch _symbol{
                    case "+","-":
                        if(pendingBinaryOperation==nil){
                            if(pendingMultiplexerOperation != nil){
                                performMultiplexerBinaryOperation()
                            }
                            pendingBinaryOperation=PendingBinaryOperation(function:function,firstOperand:accumlator!)
                        }else{
                            performMultiplexerBinaryOperation()
                            performPendingBinaryOperation()
                            pendingBinaryOperation=PendingBinaryOperation(function:function,firstOperand:accumlator!)
                        }
                    case "x","÷":
                        if(pendingMultiplexerOperation != nil){
                            performMultiplexerBinaryOperation()
                        }
                        pendingMultiplexerOperation=PendingBinaryOperation(function:function,firstOperand:accumlator!)
                        
                    default:
                        break
                    }
                    
                }
            case .unaryOperation(let function):
                accumlator = function(accumlator!)
            case .specialOperation(let function):
                if let currentNum = accumlator {
                    accumlator = function(currentNum)
                    
                }
            case .equals:
                performMultiplexerBinaryOperation()
                performPendingBinaryOperation()
            }
            
        }
    }
    private mutating func performMultiplexerBinaryOperation(){
        if pendingMultiplexerOperation != nil {
            accumlator = pendingMultiplexerOperation!.perform(with: accumlator!)
            pendingMultiplexerOperation = nil
        }
    }
    private mutating func performPendingBinaryOperation(){
       
        if pendingBinaryOperation != nil && accumlator != nil{
            accumlator=pendingBinaryOperation!.perform(with: accumlator!)
            pendingBinaryOperation = nil
        }
    }
    mutating func setOperand(_operand:Double){
        accumlator=_operand
    }
    mutating func resetMultiplexer(){
        multiplexer = 0
    }
    var result:Double?{
        mutating get{
            return accumlator
        }
    }
}
