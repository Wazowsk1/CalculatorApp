import SwiftUI

struct MainCalculatorView: View {
  
  @State var lightMode = true
  @State var currentComputation = ""
  @State var mainResult = "0"
  
  var body: some View {
    ZStack {
      Color.calcBG.edgesIgnoringSafeArea(.all)
      
      VStack {
        SunMoonView(lightMode: lightMode)
          .onTapGesture {
            withAnimation {
              lightMode.toggle()
            }
          }
        
        Spacer()
        
        ComputationView(
          currentComputation: currentComputation,
          mainResult: mainResult
        )
        
        Spacer()
        
        CalcButtonView(
          currentComputation: $currentComputation,
          mainResult: $mainResult
        )
      }
      .padding()
    }
    .environment(\.colorScheme, lightMode ? .light : .dark)
  }
}

#Preview {
  MainCalculatorView()
}
