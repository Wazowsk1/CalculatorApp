import SwiftUI

struct SunMoonView: View {
  var lightMode: Bool
  
  var body: some View {
    HStack(spacing: 30) {
      Image(systemName: "sun.min")
        .imageScale(.large)
      
      Image(systemName: "moon")
        .imageScale(.large)
    }
    .padding()
    .background(.calcSecondary)
    .clipShape(RoundedRectangle(cornerRadius: 20))
  }
}

#Preview {
  SunMoonView(lightMode: true)
}
