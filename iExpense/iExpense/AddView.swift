//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct AddView: View {
  @Environment(\.modelContext) var modelContext
  @Environment(\.dismiss) var dismiss

  @State private var name = "New Expense"
  @State private var type = "Personal"
  @State private var amount = 0.0

  let types = ["Business", "Personal"]

  var body: some View {
    NavigationStack {
      Form {
        Picker("Type", selection: $type) {
          ForEach(types, id: \.self) {
            Text($0)
          }
        }
        TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
          .keyboardType(.decimalPad)
      }
      .navigationTitle($name)
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        Button("Save") {
          let item = Expense(name: name, type: type, amount: amount)
          modelContext.insert(item)
          dismiss()
        }
      }
    }
  }
}

#Preview {
  AddView()
}
