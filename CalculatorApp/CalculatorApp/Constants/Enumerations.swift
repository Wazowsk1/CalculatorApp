import Foundation

enum Operation {
  case add, substact, multiply, divide, equal, none
}

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
  case substact = "-"
  case multiply = "×"
  case divide = "÷"
  case equal = "="
  case clear = "AC"
  case decimal = "."
  case percent = "%"
  case negative = "IMGplus.forwardslash.minus"
  case undo = "IMGarrow.uturn.backward"
}

let enumOperators: [CalcButton] = [.substact, .add, .divide, .multiply]

let multiplySymbol = CalcButton.multiply.rawValue
let divionSymbol = CalcButton.divide.rawValue

let operators = "+-\(multiplySymbol)\(divionSymbol)"
