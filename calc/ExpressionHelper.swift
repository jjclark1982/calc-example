//
//  ExpressionHelper.swift
//  calc
//

import Foundation

/*
 * A helper class to assist in manipulating a given infix expression.
 */
class ExpressionHelper {
    
    // Private class fields
    private var operators: [Operator] = [Operator]()
    private var expression: [Node] = [Node]()
    
    
    /*
     * ExpressionHelper()
     *
     * A constructor that nodifies each value in a given expression and
     * initialises the operators that may be used to solve it.
     */
    init() {}
    
    /*
     * setValues(values: [String]) throws
     *
     * A public method that nodifies each value in a given expression.
     *
     * Will throw a errors if values are invalid
     */
    func setValues(values: [String]) throws {
        try nodifyValues(values: values)
    }
    
    
    /*
     * convertToPostfix() throws
     *
     * A public method used to convert an infix expression into a
     * postfix expression by applying a Shunting-yard algorithm.
     */
    func convertToPostfix() throws {
        // [REDACTED]
    }
    
    
    /*
     * solveExpression() throws -> Int
     *
     * A helper method to solve a postfix notation expression,
     * returning it as an integer value.
     */
    private func solveExpression() throws -> Int {
        var stack = [Node]()
        
        for node in expression {
            if try node.isOperandNode() {
                stack.append(node)
            }
            else {
                let valueOne: Int = stack.popLast()!.getIntValue()
                let valueTwo: Int = stack.popLast()!.getIntValue()
                let operatorType: Operator = try getOperator(operatorNode: node)
                let result: Int = try operatorType.performOperation(operandOne: valueOne, operandTwo: valueTwo)
                let resultString: String = String(result)
                stack.append(Node(value: resultString))
            }
        }
        return stack.popLast()!.getIntValue()
    }
    
    
    /*
     * nodifyValues(values: [String]) throws
     *
     * A helper function to turn all given values of a string array
     * into node values and store them in the expression array.
     *
     * Will throw errors if a given value is invalid.
     */
    private func nodifyValues(values: [String]) throws {
        for value in values {
            let node = Node(value: value)
            if try !node.isOperandNode() && node.getValue() != "(" && node.getValue() != ")" {
                try _ = getOperator(operatorNode: node)
            }
            expression.append(node)
        }
    }
    
    
    private func getNodePrecedence(operatorNode: Node) throws -> Int {
        return try getOperator(operatorNode: operatorNode).getPrecedence()
    }
    
    
    /*
     * getOperator(operatorNode: Node) throws -> Operator?
     *
     * A helper function to lookup and return the corresponding
     * Operator object by comparing it to a given node's String value.
     *
     * Will throw an error if the operator cannot be found (undefined).
     */
    private func getOperator(operatorNode: Node) throws -> Operator {
        let foundOperator = Operator.definedOperators[operatorNode.getValue()]
        if foundOperator != nil {
            return foundOperator!
        }
        throw CalculationError.undefinedOperator(undefinedOperator: operatorNode.getValue())
    }
    
    
    /*
     * printExpression()
     *
     * A public function that prints out an expression as it currently appears
     * in the expression array.
     */
    func printExpression() {
        var outputString: String = ""
        for node in expression {
            outputString += node.getValue() + " "
        }
        print(outputString)
    }
    
    
    /*
     * printSolvedExpression()
     *
     * A public function that prints out the result of an expression using the
     * solveExpression() helper function.
     */
    func printSolvedExpression() throws {
        print(try solveExpression())
    }
    
}
