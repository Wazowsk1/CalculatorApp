import SwiftUI

class CalculatorViewModel: ObservableObject {
  // MARK: - Properties
  @Published var currentComputation: String = ""
  @Published var mainResult: String = "0"
  
  // MARK: - Handling button presses
  func buttonPressed(calcButton: CalcButton) {
    switch calcButton {
      case .clear: handleClear()
      case .equal: handleEqual()
      case .percent: handlePercent()
      case .undo: handleUndo()
      case .negative: handleNegative()
      case .decimal: handleDecimal()
      default: handleDefault(calcButton)
    }
  }
  
  // MARK: - Func Handling
  private func handleClear() {
    currentComputation = ""
    mainResult = "0"
  }
  
  private func handleEqual() {
    let expression = NSExpression(format: currentComputation)
    if let result = expression.expressionValue(with: nil, context: nil) as? Double {
      mainResult = formatResult(result)
      currentComputation = mainResult
    }
  }
  
  private func handlePercent() {
    if let value = Double(currentComputation) {
      mainResult = formatResult(value / 100)
      currentComputation = mainResult
    }
  }
  
  private func handleUndo() {
    if !currentComputation.isEmpty {
      currentComputation.removeLast()
    }
  }
  
  private func handleNegative() {
    if currentComputation.isEmpty {
      currentComputation = "-0"
      return
    }
    
    let components = currentComputation.split(whereSeparator: { "+-×÷".contains($0) }).map { String($0) }
    
    guard let lastNumber = components.last, let range = currentComputation.range(of: lastNumber) else {
      return
    }
    
    if lastNumber.hasPrefix("-") {
      currentComputation.replaceSubrange(range, with: String(lastNumber.dropFirst()))
    } else {
      currentComputation.replaceSubrange(range, with: "-" + lastNumber)
    }
  }
  
  private func handleDecimal() {
    let components = currentComputation.split(whereSeparator: { "+-×÷".contains($0) })
    if let lastComponent = components.last, lastComponent.contains(".") {
      return
    }
    if currentComputation.isEmpty || lastCharacterIsAnOperator(str: currentComputation) {
      currentComputation += "0."
    } else {
      currentComputation += "."
    }
  }
  
  private func handleDefault(_ calcButton: CalcButton) {
    currentComputation += calcButton.rawValue
  }
  
  // MARK: - Helper Methods
  private func formatResult(_ val: Double) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    numberFormatter.maximumFractionDigits = 16
    return numberFormatter.string(from: NSNumber(value: val)) ?? "0"
  }
  
  private func lastCharacterIsAnOperator(str: String) -> Bool {
    return operators.contains(str.last ?? " ")
  }
}
