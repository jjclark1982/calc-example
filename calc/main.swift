//
//  main.swift
//  calc
//
//  Created by Jesse Clark on 12/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation

var args = ProcessInfo.processInfo.arguments // Gets the startup arguments
args.removeFirst() // Removes the name of the program

// Define all operators to be used here in a similar style
func add(a:Int, b:Int)->Int {
    return a + b
}
func subtract(a:Int, b:Int)->Int {
    return a - b
}
func multiply(a:Int, b:Int)->Int {
    return a * b
}
func divide(a:Int, b:Int)->Int {
    return a / b
}
func remainder(a:Int, b:Int)->Int {
    return a % b
}
Operator.definedOperators = [
    Operator(symbol: "+", precedence: 2, operation: add),
    Operator(symbol: "-", precedence: 2, operation: subtract),
    Operator(symbol: "x", precedence: 3, operation: multiply, checkRightOperandZero: nil),
    Operator(symbol: "/", precedence: 3, operation: divide, checkRightOperandZero: true),
    Operator(symbol: "%", precedence: 3, operation: remainder)
]

// Creates an ExpressionHelper object
let expressionHelper: ExpressionHelper = ExpressionHelper()

// Catches possible errors
do {
    // Sets the the ExpressionHelper with the values supplied as arguments
    try expressionHelper.setValues(values: args)
    
    // Converts the expression to postfix notation for evaluation
    try expressionHelper.convertToPostfix()

    // Evaluates and prints the result
    try expressionHelper.printSolvedExpression()
}
catch CalculationError.undefinedOperator(let undefinedOperator) {
    print("CalculationError.undefinedOperator: Found unspecified operator \(undefinedOperator), please check input and try again.")
    exit(1)
}
catch CalculationError.dividedByZero {
    print("CalculationError.dividedByZero: Cannot divide operand by zero.")
    exit(1)
}
catch CalculationError.operandOutOfBounds(let operand) {
    print("CalculationError.operandOutOfBounds: Operand [\(operand)] too small or large to handle.")
    exit(1)
}
