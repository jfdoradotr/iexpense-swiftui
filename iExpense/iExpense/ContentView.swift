//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State private var items = [ExpenseItem]()

  var personalItems: [ExpenseItem] {
    items.filter { $0.type == "Personal" }
  }

  var businessItems: [ExpenseItem] {
    items.filter { $0.type == "Business" }
  }

  var body: some View {
    NavigationStack {
      List {
        Section(header: Text("Personal")) {
          ForEach(personalItems) { item in
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
          ForEach(businessItems) { item in
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
        NavigationLink {
          AddView(items: $items)
        } label: {
            Image(systemName: "plus")
        }
      }
    }
  }

  func removeItems(at offsets: IndexSet, in inputArray: [ExpenseItem]) {
    var objectsToDelete = IndexSet()

    for offset in offsets {
      let item = inputArray[offset]

      if let index = items.firstIndex(of: item) {
        objectsToDelete.insert(index)
      }
    }

    items.remove(atOffsets: objectsToDelete)
  }

  func removePersonalItems(at offsets: IndexSet) {
    removeItems(at: offsets, in: personalItems)
  }

  func removeBusinessItems(at offsets: IndexSet) {
    removeItems(at: offsets, in: businessItems)
  }
}

#Preview {
  ContentView()
}
