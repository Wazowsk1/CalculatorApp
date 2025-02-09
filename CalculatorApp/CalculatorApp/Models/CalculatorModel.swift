import Foundation

// MARK: - Operations
enum Operation {
  case add, subtract, multiply, divide, equal, none
}

// MARK: - Calculator Buttons
enum CalcButton: String {
  case zero = "0"
  case one = "1"
  case two = "2"
  case three = "3"
  case four = "4"
  case five = "5"
  case six = "6"
  case seven = "7"
  case eight = "8"
  case nine = "9"
  case add = "+"
  case subtract = "-"
  case multiply = "×"
  case divide = "÷"
  case equal = "="
  case clear = "AC"
  case decimal = "."
  case percent = "%"
  case negative = "IMGplus.forwardslash.minus"
  case undo = "IMGarrow.uturn.backward"
}

// MARK: - Operators
let enumOperators: [CalcButton] = [.subtract, .add, .divide, .multiply]

let multiplySymbol = CalcButton.multiply.rawValue
let divisionSymbol = CalcButton.divide.rawValue

let operators = "+-\(multiplySymbol)\(divisionSymbol)"
