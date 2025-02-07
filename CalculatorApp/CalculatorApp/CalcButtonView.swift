import SwiftUI

struct CalcButtonView: View {
  @Binding var currentComputation: String
  @Binding var mainResult: String
  
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
  CalcButtonView(
    currentComputation: .constant("5 + 5"),
    mainResult: .constant("10")
  )
}
