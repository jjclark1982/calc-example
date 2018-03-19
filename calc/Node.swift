//
//  Node.swift
//  calc
//

import Foundation

/*
 * A model class to represent a given Node.
 */
class Node {
    
    // Private class fields
    private let value: String
    
    
    /*
     * Node()
     *
     * A constructor that initialises the value of the Node.
     */
    init(value: String) {
        self.value = value
    }
    
    
    /*
     * getValue() -> String
     *
     * A getter method that returns the Node's value as a String.
     */
    func getValue() -> String {
        return value
    }
    
    
    /*
     * getIntValue() -> Int
     *
     * A getter method that returns the Node's value as an Int.
     */
    func getIntValue() -> Int {
        return Int(value)!
    }
    
    
    /*
     * isOperandNode() throws -> Bool
     *
     * A public method that returns whether the Node's value can
     * be converted to (and therefor must be) an operand as a Bool.
     *
     * Also throws an error if the value is a number but it is too
     * big or small to parse into an Int.
     */
    func isOperandNode() throws -> Bool  {
        if isNumber() && Int(value) == nil {
            throw CalculationError.operandOutOfBounds(operand: self.value)
        }
        return Int(value) != nil
    }
    
    
    /*
     * isNumber() -> Bool
     *
     * A helper function to determine if the value of the Node looks
     * like a number (either negative or positive).
     */
    private func isNumber() -> Bool {
        let numericalCharacters: CharacterSet = CharacterSet.decimalDigits
        let valueAllNumbers: Bool = CharacterSet(charactersIn: value).isSubset(of: numericalCharacters)
        let valueIsNegative: Bool = value.hasPrefix("-")
        
        if valueAllNumbers {
            return true
        }
        else if valueIsNegative && value.count > 1 {
            var firstValueSliced: String = value
            firstValueSliced.remove(at: firstValueSliced.startIndex)
            return CharacterSet(charactersIn: firstValueSliced).isSubset(of: numericalCharacters)
        }
        return false
    }
}
