//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct SecondView: View {
  var body: some View {
    Text("Second view")
  }
}

struct ContentView: View {
  @State private var showingSheet = false

  var body: some View {
    Button("Show sheet") {
      showingSheet.toggle()
    }
    .sheet(isPresented: $showingSheet) {
      SecondView()
    }
  }
}

#Preview {
  ContentView()
}
