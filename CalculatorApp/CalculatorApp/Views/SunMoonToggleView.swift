import SwiftUI

struct SunMoonToggleView: View {
  
  // MARK: - Properties
  @Binding var lightMode: Bool
  
  // MARK: - Body
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 25)
        .fill(Color.calcSecondary)
        .frame(width: 90, height: 40)
      
      HStack {
        Image(systemName: "sun.min.fill")
        Spacer()
        Image(systemName: "moon.fill")
      }
      .padding(.horizontal, 12)
      
      Circle()
        .fill(lightMode ? Color.yellow : Color.blue)
        .frame(width: 35, height: 35)
        .offset(x: lightMode ? -25 : 25)
        .animation(.spring(response: 0.4, dampingFraction: 0.6), value: lightMode)
    }
    .frame(width: 90, height: 40)
    .onTapGesture {
      withAnimation {
        lightMode.toggle()
      }
    }
  }
}

