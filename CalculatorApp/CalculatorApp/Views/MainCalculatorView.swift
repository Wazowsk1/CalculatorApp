import SwiftUI

struct MainCalculatorView: View {
  
  @State var lightMode = true
  @State var currentComputation = ""
  @State var mainResult = "0"
  
  var body: some View {
    GeometryReader { geometry in
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
          .padding(.horizontal,
                   ipadAdaptive() ? geometry.size.width * 0.1 : 0)
          
          Spacer()
          
          CalcButtonView(
            currentComputation: $currentComputation,
            mainResult: $mainResult
          )
          
          if ipadAdaptive() {
            Spacer()
          }
        }
        .padding()
      }
    }
    .environment(\.colorScheme, lightMode ? .light : .dark)
  }
}

#Preview {
  MainCalculatorView()
}
