//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct SecondView: View {
  @Environment(\.dismiss) var dismiss

  var body: some View {
    Button("Dismiss") {
      dismiss()
    }
  }
}

struct ContentView: View {
  @State private var showingSheet = false

  var body: some View {
    Button("Show Sheet") {
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
