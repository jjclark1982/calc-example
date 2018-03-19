//
//  Operator.swift
//  calc
//

import Foundation

/*
 * A model class to represent a given Operator.
 */
class Operator {
    
    // Private class fields
    private let symbol: String
    private let precedence: Int
    private let checkRightOperandZero: Bool?
    private let operation: (Int, Int) -> Int
    
    
    /*
     * Operator()
     *
     * A constructor that initialises the symbol and precendence of
     * the Operator, as well as the operation function.
     */
    init(symbol: String, precedence: Int, operation: @escaping (Int, Int) -> Int, checkRightOperandZero: Bool? = false) {
        self.symbol = symbol
        self.precedence = precedence
        self.operation = operation // This is a function matching (Int, Int) -> Int
        self.checkRightOperandZero = checkRightOperandZero
    }
    
    
    /*
     * getSymbol() -> String
     *
     * A getter method that returns the Operator's symbol as a String.
     */
    func getSymbol() -> String {
        return symbol
    }
    
    
    /*
     * getPrecedence() -> Int
     *
     * A getter method that returns the Operator's precedence as an Int.
     */
    func getPrecedence() -> Int {
        return precedence
    }
    
    
    /*
     * performOperation(operandOne: Int, operandTwo: Int) -> Int
     *
     * A public method that performs the Operator's operation on two
     * supplied Int values (the operands) and returns the result.
     */
    func performOperation(operandOne: Int, operandTwo: Int) throws -> Int {
        if checkRightOperandZero! && operandOne == 0{
            throw CalculationError.dividedByZero
        }
        return operation(operandTwo, operandOne)
    }
}
