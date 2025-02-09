import SwiftUI

struct ButtonView: View {
  let calcButton: CalcButton
  
  let fgColor: Color
  let bgColor: Color
  
  var systemImage: String? {
    let value = calcButton.rawValue
    return value
      .contains("IMG") ? value
      .replacingOccurrences(of: "IMG", with: "") : nil
  }
  
  var text: String? {
    let value = calcButton.rawValue
    return value
      .contains("IMG") ? nil : value
  }
  
  let buttonDiM: CGFloat = UIScreen.main.bounds.width / 5
  
  var body: some View {
    ZStack {
      Text(text ?? "")
      
      Image(systemName: systemImage ?? "")
    }
    .font(.title2)
    .fontWeight(.semibold)
    .frame(width: buttonDiM, height: buttonDiM)
    .foregroundStyle(fgColor)
    .background(bgColor)
    .clipShape(RoundedRectangle(cornerRadius: 16))
    .shadow(color: bgColor.opacity(0.5), radius: 3, x: 5, y: 5)
  }
}

#Preview {
  VStack {
    ButtonView(
      calcButton: .one,
      fgColor: .calcText,
      bgColor: .calcThirds
    )
    
    ButtonView(
      calcButton: .undo,
      fgColor: .calcText,
      bgColor: .calcThirds
    )
    
    ButtonView(
      calcButton: .percent,
      fgColor: .calcCyan,
      bgColor: .calcThirds
    )
    
    ButtonView(
      calcButton: .divide,
      fgColor: .calcOrange,
      bgColor: .calcThirds
    )
  }
}
