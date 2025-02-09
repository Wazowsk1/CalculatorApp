import SwiftUI

struct SunMoonView: View {
  var lightMode: Bool
  
  var body: some View {
    HStack(spacing: 0) {
      Image(systemName: "sun.min")
        .foregroundStyle(lightMode ? Color.white : Color.secondary)
        .frame(width: 20, height: 20)
        .padding()
        .padding(.leading, 10)
        .background(lightMode ? Color(.yellow) : Color(.systemGray5))
      
      Image(systemName: "moon")
        .foregroundStyle(lightMode ? Color.secondary : Color.white)
        .frame(width: 20, height: 20)
        .padding()
        .padding(.trailing, 10)
        .background(lightMode ? Color(.systemGray5) : Color(.blue))
    }
    .imageScale(.large)
    .font(ipadAdaptive() ? .title : .body)
    .fontWeight(ipadAdaptive() ? .semibold : .regular)
//    .padding()
//    .background(.calcThirds)
    .clipShape(RoundedRectangle(cornerRadius: 20))
  }
}

#Preview {
  SunMoonView(lightMode: true)
}
