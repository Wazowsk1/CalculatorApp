import SwiftUI

struct ComputationView: View {
  let currentComputation: String
  let mainResult: String
  
  var body: some View {
    VStack {
      Text(currentComputation)
      Text(mainResult)
    }
  }
}

#Preview {
  ComputationView(
    currentComputation: "5 + 5",
    mainResult: "10"
  )
}
