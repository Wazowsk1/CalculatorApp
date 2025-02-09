import SwiftUI

struct MainCalculatorView: View {
  
  //MARK: - Properties
  @State var lightMode = false
  @State var currentComputation = ""
  @State var mainResult = "0"
  
  //MARK: - Body
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        Color.calcBG.edgesIgnoringSafeArea(.all)
        
        VStack {
          //MARK: - Theme Toggle (Sun/Moon)
          SunMoonToggleView(lightMode: $lightMode)
            .onTapGesture {
              withAnimation {
                lightMode.toggle()
              }
            }
          
          Spacer()
          
          //MARK: - Computation Display
          ComputationView(
            currentComputation: currentComputation,
            mainResult: mainResult
          )
          
          Spacer()
          
          //MARK: - Calculator Buttons
          CalcButtonView(
            currentComputation: $currentComputation,
            mainResult: $mainResult,
            screenWidth: geometry.size.width
          )
          .padding(.leading, -5)
        }
        .padding()
      }
    }
    .environment(\.colorScheme, lightMode ? .light : .dark)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

//MARK: - Preview
#Preview {
  MainCalculatorView()
}
