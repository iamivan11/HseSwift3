//  main.swift
//  HW_Swift_Sorokin
//
//  Created by Ivan on 2/1/24.

import Foundation

enum Operation: String {
    case plus = "+"
    case minus = "-"
    case multiply = "*"
    case divide = "/"
    case squareRoot = "sr"
}

struct CalculationData {
    var number1: Double
    var number2: Double?
    var operation: Operation
}

class InputHandler {
    func requestNumber(text: String) -> Double {
        print(text)
        guard let input = readLine(), let number = Double(input) else {
            print("Invalid input. Please enter a valid number.")
            return requestNumber(text: text)
        }
        return number
    }
    
    func requestOperation(text: String) -> Operation {
        print(text)
        guard let input = readLine(), let operation = Operation(rawValue: input) else {
            print("Invalid input. Please enter a valid operation symbol.")
            return requestOperation(text: text)
        }
        return operation
    }
    
    func shouldContinue() -> Bool {
        while true {
            print("Would you like to perform another calculation?")
            print("No - 0")
            print("Yes - 1")
            print("", terminator: "")
            if let input = readLine() {
                switch input {
                case "1":
                    return true
                case "0":
                    print("==================================")
                    return false
                default:
                    print("Invalid input. Please enter '0' for no or '1' for yes.")
                }
            }
        }
    }
}

class Calculator {
    func add(number1: Double, number2: Double) -> Double {
        return number1 + number2
    }
    
    func subtract(number1: Double, number2: Double) -> Double {
        return number1 - number2
    }
    
    func multiply(number1: Double, number2: Double) -> Double {
        return number1 * number2
    }
    
    func divide(number1: Double, number2: Double) -> Double? {
        guard number2 != 0 else {
            print("Error: Division by zero is not allowed.")
            return nil
        }
        return number1 / number2
    }
    
    func squareRoot(number1: Double) -> Double? {
        guard number1 >= 0 else {
            print("Error: Square root of negative number is undefined.")
            return nil
        }
        return sqrt(number1)
    }
    
    func calculateTwo(data: CalculationData) -> Double? { // Operations for two numbers
        guard let number2 = data.number2 else { return nil }
        switch data.operation {
        case .plus:
            return add(number1: data.number1, number2: number2)
        case .minus:
            return subtract(number1: data.number1, number2: number2)
        case .multiply:
            return multiply(number1: data.number1, number2: number2)
        case .divide:
            return divide(number1: data.number1, number2: number2)
        default:
            print("Invalid operation for two numbers.")
            return nil
        }
    }
    
    func calculateOne(data: CalculationData) -> Double? { // Operations for one number only
        // Separated calculateOne and calculateTwo functions for clearer code structure
        switch data.operation {
        case .squareRoot:
            return squareRoot(number1: data.number1)
        default:
            print("Invalid operation for one number.")
            return nil
        }
    }
    
    func isSingleNumberOperation(operation: Operation) -> Bool {
        switch operation {
        case .squareRoot: // Add any other single-number operation
            return true
        default:
            return false
        }
    }
}

class CalculatorApp {
    let calculator = Calculator()
    let inputHandler = InputHandler()
    
    func run() {
        var continueCalculation = true
        
        while continueCalculation {
            print("===============================")
            print("")
            let firstNumber = inputHandler.requestNumber(text: "Please, enter the first number:")
            let operation = inputHandler.requestOperation(text: "Please, enter the operation type:")
            var data = CalculationData(number1: firstNumber, number2: nil, operation: operation)
            // Check if the operation is a single-number operation
            if calculator.isSingleNumberOperation(operation: operation) {
                if let result = calculator.calculateOne(data: data) {
                    print("*******")
                    print("RESULT: \(result)")
                    print("*******")
                } else {
                    print("An error occurred during the calculation.")
                }
            } else {
                let secondNumber = inputHandler.requestNumber(text: "Please, enter the second number:")
                data.number2 = secondNumber
                if let result = calculator.calculateTwo(data: data) {
                    print("*******")
                    print("RESULT: \(result)")
                    print("*******")
                } else {
                    print("An error occurred during the calculation.")
                }
            }
            print("")
            continueCalculation = inputHandler.shouldContinue()
        }
    }
}

let app = CalculatorApp()
app.run()
