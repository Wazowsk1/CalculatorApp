import SwiftUI

struct ComputationView: View {
  
  //MARK: - Properties
  let currentComputation: String
  let mainResult: String
  
  //MARK: - Body
  var body: some View {
    VStack(spacing: 10) {
      HStack {
        Spacer()
        
        Text(currentComputation)
          .foregroundStyle(.calcText)
          .lineLimit(1)
      }
      .minimumScaleFactor(0.1)
      
      HStack {
        Spacer()
        
        Text(mainResult)
          .foregroundStyle(.calcText)
          .lineLimit(1)
          .font(.largeTitle)
          .fontWeight(.bold)
      }
      .minimumScaleFactor(0.1)
    }
    .padding(.horizontal)
  }
}

