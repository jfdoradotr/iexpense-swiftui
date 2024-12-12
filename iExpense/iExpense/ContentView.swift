//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @AppStorage("tapCount") private var tapCount = 0

  var body: some View {
    Button("Tap Count: \(tapCount)") {
      tapCount += 1
    }
  }
}

#Preview {
  ContentView()
}
