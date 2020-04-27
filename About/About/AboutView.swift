import SwiftUI

struct AboutView: View {
  var body: some View {
    VStack {
      Text("Timer")
        .font(.title)
      Text("Version 0.1")
        .font(.footnote)
        .padding(5)
        .padding(.bottom, 10)
    }
    .frame(width: 200, height: 100)
  }
}

struct AboutView_Previews: PreviewProvider {
  static var previews: some View {
    AboutView()
  }
}
