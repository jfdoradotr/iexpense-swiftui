//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")

  var body: some View {
    Button("Tap Count: \(tapCount)") {
      tapCount += 1

      UserDefaults.standard.set(tapCount, forKey: "Tap")
    }
  }
}

#Preview {
  ContentView()
}
