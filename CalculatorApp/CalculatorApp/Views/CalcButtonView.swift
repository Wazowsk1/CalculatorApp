import SwiftUI

struct CalcButtonView: View {
  
  //MARK: - Properties
  @ObservedObject var viewModel: CalculatorViewModel
  var screenWidth: CGFloat
  
  let buttonData: [[CalcButton]] = [
    [.clear, .negative, .percent, .divide],
    [.seven, .eight, .nine, .multiply],
    [.four, .five, .six, .subtract],
    [.one, .two, .three, .add],
    [.undo, .zero, .decimal, .equal]
  ]
  
  //MARK: - Body
  var body: some View {
    Grid {
      ForEach(buttonData, id: \.self) { row in
        GridRow {
          ForEach(row, id: \.self) { button in
            Button {
              viewModel.buttonPressed(calcButton: button)
            } label: {
              ButtonView(
                calcButton: button,
                fgColor: CalcButtonView.buttonColor(button),
                bgColor: .calcSecondary,
                screenWidth: screenWidth
              )
            }
          }
        }
      }
    }
    .padding()
    .padding(.leading, -10)
    .background(Color.calcThirds)
    .clipShape(RoundedRectangle(cornerRadius: 20))
  }
  
  static func buttonColor(_ button: CalcButton) -> Color {
    if enumOperators.contains(button) || button == .equal {
      return .calcOrange
    } else if button == .clear || button == .negative || button == .percent {
      return .calcCyan
    } else {
      return .calcText
    }
  }
}
