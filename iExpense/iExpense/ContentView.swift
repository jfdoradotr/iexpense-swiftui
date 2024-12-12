//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable, Equatable {
  var id = UUID()
  let name: String
  let type: String
  let amount: Double
}

@Observable
class Expenses {
  var items = [ExpenseItem]() {
    didSet {
      if let encoded = try? JSONEncoder().encode(items) {
        UserDefaults.standard.set(encoded, forKey: "Items")
      }
    }
  }

  var personalItems: [ExpenseItem] {
    items.filter { $0.type == "Personal" }
  }

  var businessItems: [ExpenseItem] {
    items.filter { $0.type == "Business" }
  }

  init() {
    if let savedItems = UserDefaults.standard.data(forKey: "Items") {
      if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
        items = decodedItems
        return
      }
    }
    items = []
  }
}

struct ContentView: View {
  @State private var expenses = Expenses()
  @State private var showingAddExpense = false

  var body: some View {
    NavigationStack {
      List {
        Section(header: Text("Personal")) {
          ForEach(expenses.personalItems) { item in
            HStack {
              VStack(alignment: .leading) {
                Text(item.name)
                  .font(.headline)
                Text(item.type)
                  .font(.subheadline)
              }
              Spacer()
              Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .font(item.amount < 10 ? .footnote : item.amount < 100 ? .subheadline : .headline)
                .foregroundStyle(item.amount < 10 ? .green : item.amount < 100 ? .yellow : .red)
            }
          }
          .onDelete(perform: removePersonalItems)
        }
        Section(header: Text("Business")) {
          ForEach(expenses.businessItems) { item in
            HStack {
              VStack(alignment: .leading) {
                Text(item.name)
                  .font(.headline)
                Text(item.type)
                  .font(.subheadline)
              }
              Spacer()
              Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .font(item.amount < 10 ? .footnote : item.amount < 100 ? .subheadline : .headline)
                .foregroundStyle(item.amount < 10 ? .green : item.amount < 100 ? .yellow : .red)
            }
          }
          .onDelete(perform: removeBusinessItems)
        }
      }
      .navigationTitle("iExpense")
      .toolbar {
        Button("Add Expense", systemImage: "plus") {
          showingAddExpense = true
        }
      }
      .sheet(isPresented: $showingAddExpense) {
        AddView(expenses: expenses)
      }
    }
  }

  func removeItems(at offsets: IndexSet, in inputArray: [ExpenseItem]) {
    var objectsToDelete = IndexSet()

    for offset in offsets {
      let item = inputArray[offset]

      if let index = expenses.items.firstIndex(of: item) {
        objectsToDelete.insert(index)
      }
    }

    expenses.items.remove(atOffsets: objectsToDelete)
  }

  func removePersonalItems(at offsets: IndexSet) {
    removeItems(at: offsets, in: expenses.personalItems)
  }

  func removeBusinessItems(at offsets: IndexSet) {
    removeItems(at: offsets, in: expenses.businessItems)
  }
}

#Preview {
  ContentView()
}
