import SwiftUI

struct CalcButtonModel: Identifiable {
  let id = UUID()
  let calcButton: CalcButton
  var color: Color = .calcText
}

struct RowOfCalcButtonModel: Identifiable {
  let id = UUID()
  let row: [CalcButtonModel]
}

struct CalcButtonView: View {
  @Binding var currentComputation: String
  @Binding var mainResult: String
  
  var screenWidth: CGFloat
  
  //MARK: - Button Data
  let buttonData: [RowOfCalcButtonModel] = [
    RowOfCalcButtonModel(row: [
      CalcButtonModel(calcButton: .clear, color: .calcCyan),
      CalcButtonModel(calcButton: .negative, color: .calcCyan),
      CalcButtonModel(calcButton: .percent, color: .calcCyan),
      CalcButtonModel(calcButton: .divide, color: .calcOrange)
    ]),
    RowOfCalcButtonModel(row: [
      CalcButtonModel(calcButton: .seven),
      CalcButtonModel(calcButton: .eight),
      CalcButtonModel(calcButton: .nine),
      CalcButtonModel(calcButton: .multiply, color: .calcOrange),
    ]),
    RowOfCalcButtonModel(row: [
      CalcButtonModel(calcButton: .four),
      CalcButtonModel(calcButton: .five),
      CalcButtonModel(calcButton: .six),
      CalcButtonModel(calcButton: .subtract, color: .calcOrange),
    ]),
    RowOfCalcButtonModel(row: [
      CalcButtonModel(calcButton: .one),
      CalcButtonModel(calcButton: .two),
      CalcButtonModel(calcButton: .three),
      CalcButtonModel(calcButton: .add, color: .calcOrange),
    ]),
    RowOfCalcButtonModel(row: [
      CalcButtonModel(calcButton: .undo),
      CalcButtonModel(calcButton: .zero),
      CalcButtonModel(calcButton: .decimal),
      CalcButtonModel(calcButton: .equal, color: .calcOrange),
    ])
  ]
  
  //MARK: - Body
  var body: some View {
    Grid {
      ForEach(buttonData) { rowOfCalcButtonModel in
        GridRow {
          ForEach(rowOfCalcButtonModel.row) { calcButtonModel in
            Button {
              buttonPressed(calcButton: calcButtonModel.calcButton)
            } label: {
              ButtonView(
                calcButton: calcButtonModel.calcButton,
                fgColor: calcButtonModel.color,
                bgColor: .calcSecondary,
                screenWidth: screenWidth
              )
            }
          }
        }
      }
    }
    .padding()
    .background(.calcThirds)
    .clipShape(RoundedRectangle(cornerRadius: 20))
  }
  
  //MARK: - Button Handling
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
  
  //MARK: - Button Actions
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
    
    let components = currentComputation
      .split(whereSeparator: { "+-×÷".contains($0) }).map { String($0) }
    
    guard let lastNumber = components.last,
          let range = currentComputation.range(of: lastNumber) else {
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

  
  //MARK: - Calculation
  func calculateResults() -> Double {
    var workings = currentComputation
      .replacingOccurrences(of: "%", with: "*0.01")
      .replacingOccurrences(of: multiplySymbol, with: "*")
      .replacingOccurrences(of: divisionSymbol, with: "/")
    
    if getLastChar(str: currentComputation) == "." {
      workings += "0"
    }
    
    let expr = NSExpression(format: workings)
    return expr.expressionValue(with: nil, context: nil) as? Double ?? 0.0
  }
  
  func appendToCurrentComputation(_ calcButton: CalcButton) {
    return currentComputation += calcButton.rawValue
  }
}

