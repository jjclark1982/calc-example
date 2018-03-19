//
//  CalculationError.swift
//  calc
//

import Foundation

/*
 * An custom error enum that defines calculation type errors.
 */
enum CalculationError: Error {
    // Error for unknown operators
    case undefinedOperator(undefinedOperator: String)
    
    // Error for dividing by zero
    case dividedByZero
    
    // Error for out-of-bounds Int values
    case operandOutOfBounds(operand: String)
}
