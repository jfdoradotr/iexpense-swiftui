//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct SecondView: View {
  let name: String

  var body: some View {
    Text("Hello \(name)")
  }
}

struct ContentView: View {
  @State private var showingSheet = false

  var body: some View {
    Button("Show Sheet") {
      showingSheet.toggle()
    }
    .sheet(isPresented: $showingSheet) {
      SecondView(name: "@jfdoradotr")
    }
  }
}

#Preview {
  ContentView()
}
