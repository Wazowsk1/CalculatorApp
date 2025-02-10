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
      CalcButtonModel(calcButton: .substact, color: .calcOrange),
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
                bgColor: .calcSecondary
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
  
  func buttonPressed(calcButton: CalcButton) {
    switch calcButton {
      case .clear:
        currentComputation = ""
        mainResult = "0"
        
      case .equal, .negative:
        if !currentComputation.isEmpty {
          if !lastCharacterIsAnOperator(str: currentComputation) {
            let sign = calcButton == .negative ? -1.0 : 1.0
            
            mainResult = formatResult(val: sign * calculateResults())
            
            if calcButton == .negative {
              currentComputation = mainResult
            }
          }
        }
        
      case .decimal:
        if let lastOccurenceOfDecimal = currentComputation.lastIndex(of: ".") {
          if lastCharIsDigit(str: currentComputation) {
            let startIndex = currentComputation
              .index(lastOccurenceOfDecimal, offsetBy: 1)
            
            let endIndex = currentComputation
              .endIndex
            
            let range = startIndex..<endIndex
            
            let rightSubString = String(currentComputation[range])
            
            if Int(rightSubString) == nil && !rightSubString.isEmpty {
              currentComputation += "."
            }
          }
        } else {
          if currentComputation.isEmpty {
            currentComputation += "0."
          } else if lastCharIsDigit(str: currentComputation){
            currentComputation += "."
          }
        }
        
      case .percent:
        if lastCharIsDigit(str: currentComputation) {
          appendToCurrectComputation(calcButton)
        }
        
      case .undo:
        currentComputation = String(currentComputation.dropLast())
        
      case .add, .substact, .multiply, .divide:
        // Needs further implementation
        if lastCharIsDigitOrPercent(str: currentComputation) {
          appendToCurrectComputation(calcButton)
        }
        
        
      default:
        // Needs further implementation
        appendToCurrectComputation(calcButton)
    }
  }
  
  // Implements the actual computation
  func calculateResults() -> Double {
    let visibleWorkings = currentComputation
    var workings = visibleWorkings
      .replacingOccurrences(of: "%", with: "*0.01")
    workings = workings
      .replacingOccurrences(of: multiplySymbol, with: "*")
    workings = workings
      .replacingOccurrences(of: divionSymbol, with: "/")
    
    if getLastChar(str: visibleWorkings) == "." {
      workings += "0"
    }
    
    let expr = NSExpression(format: workings)
    let exprValue = expr
      .expressionValue(with: nil, context: nil) as! Double
    
    return exprValue
  }
  
  func appendToCurrectComputation(_ calcButton: CalcButton) {
    return currentComputation += calcButton.rawValue
  }
}

#Preview {
  CalcButtonView(
    currentComputation: .constant("5 + 5"),
    mainResult: .constant("10")
  )
}
