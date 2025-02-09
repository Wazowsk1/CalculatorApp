import SwiftUI

struct ButtonView: View {
  
  //MARK: - Properties
  let calcButton: CalcButton
  let fgColor: Color
  let bgColor: Color
  let buttonDim: CGFloat
  
  //MARK: - Computed Properties
  var systemImage: String? {
    calcButton.rawValue.contains("IMG") ? calcButton.rawValue.replacingOccurrences(of: "IMG", with: "") : nil
  }
  
  var text: String? {
    calcButton.rawValue.contains("IMG") ? nil : calcButton.rawValue
  }
  
  // MARK: - Initializer
  init(calcButton: CalcButton, fgColor: Color, bgColor: Color, screenWidth: CGFloat) {
    self.calcButton = calcButton
    self.fgColor = fgColor
    self.bgColor = bgColor
    self.buttonDim = screenWidth / 5
  }

  //MARK: - Body
  var body: some View {
    ZStack {
      if let text = text {
        Text(text)
      }
      
      if let systemImage = systemImage {
        Image(systemName: systemImage)
      }
    }
    .font(.title2)
    .fontWeight(.semibold)
    .frame(width: buttonDim, height: buttonDim)
    .foregroundStyle(fgColor)
    .background(bgColor)
    .clipShape(RoundedRectangle(cornerRadius: 16))
  }
}
