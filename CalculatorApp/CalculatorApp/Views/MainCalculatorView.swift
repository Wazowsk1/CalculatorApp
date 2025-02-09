import SwiftUI

struct MainCalculatorView: View {
  
  //MARK: - Properties
  @StateObject private var viewModel = CalculatorViewModel()
  @State var lightMode = true
  
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        Color.calcBG.edgesIgnoringSafeArea(.all)
        
        VStack {
          SunMoonToggleView(lightMode: $lightMode)
            .onTapGesture {
              withAnimation {
                lightMode.toggle()
              }
            }
          
          Spacer()
          
          ComputationView(
            currentComputation: viewModel.currentComputation,
            mainResult: viewModel.mainResult
          )
          
          Spacer()
          
          CalcButtonView(viewModel: viewModel, screenWidth: geometry.size.width)
          
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
