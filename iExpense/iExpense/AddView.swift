//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct AddView: View {
  @State private var name = ""
  @State private var type = "Personal"
  @State private var amount = 0.0

  let types = ["Business", "Personal"]

  var expenses: Expenses

  var body: some View {
    NavigationStack {
      Form {
        TextField("Name", text: $name)
        Picker("Type", selection: $type) {
          ForEach(types, id: \.self) {
            Text($0)
          }
        }
        TextField("Amount", value: $amount, format: .currency(code: "USD"))
          .keyboardType(.decimalPad)
      }
      .navigationTitle("Add New Expense")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        Button("Save") {
          let item = ExpenseItem(name: name, type: type, amount: amount)
          expenses.items.append(item)
        }
      }
    }
  }
}

#Preview {
  AddView(expenses: Expenses())
}