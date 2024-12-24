//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftData
import SwiftUI

struct ContentView: View {
  @Environment(\.modelContext) var modelContext
  @Query private var items: [Expense]

  var personalItems: [Expense] {
    items.filter { $0.type == "Personal" }
  }

  var businessItems: [Expense] {
    items.filter { $0.type == "Business" }
  }

  var body: some View {
    NavigationStack {
      List {
        SectionView(
          name: "Personal",
          items: personalItems,
          onDelete: removePersonalItems
        )
        SectionView(
          name: "Business",
          items: businessItems,
          onDelete: removeBusinessItems
        )
      }
      .navigationTitle("iExpense")
      .toolbar {
        NavigationLink {
          AddView()
        } label: {
            Image(systemName: "plus")
        }
      }
    }
  }

  func removeItems(at offsets: IndexSet, in inputArray: [Expense]) {
    for offset in offsets {
      let item = inputArray[offset]
      modelContext.delete(item)
    }
  }

  func removePersonalItems(at offsets: IndexSet) {
    removeItems(at: offsets, in: personalItems)
  }

  func removeBusinessItems(at offsets: IndexSet) {
    removeItems(at: offsets, in: businessItems)
  }
}

// MARK: - SectionView

private extension ContentView {
  struct SectionView: View {
    let name: String
    let items: [Expense]
    let onDelete: (IndexSet) -> Void

    var body: some View {
      Section(header: Text(name)) {
        ForEach(items) { item in
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
        .onDelete(perform: onDelete)
      }
    }
  }
}

// MARK: - Previews

#Preview {
  ContentView()
}
