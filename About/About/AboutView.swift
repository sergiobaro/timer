import SwiftUI

struct AboutView: View {

  let title: String
  let version: String

  var body: some View {
    VStack {
      Text(title)
        .font(.title)
      Text(version)
        .font(.footnote)
        .padding(5)
        .padding(.bottom, 10)
    }
    .frame(width: 200, height: 100)
  }
}

struct AboutView_Previews: PreviewProvider {
  static var previews: some View {
    AboutView(title: "Timer", version: "0.1")
  }
}
