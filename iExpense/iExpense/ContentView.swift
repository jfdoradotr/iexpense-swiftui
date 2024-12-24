//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftData
import SwiftUI

struct ContentView: View {
  @Environment(\.modelContext) var modelContext
  @Query private var items: [Expense]

  var body: some View {
    NavigationStack {
      List {
        Section {
          ForEach(items) { item in
            HStack {
              VStack(alignment: .leading, spacing: 5) {
                Text(item.name)
                  .font(.headline)
                HStack(spacing: 5) {
                  Image(systemName: item.typeImageName)
                  Text(item.type)
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
              }
              Spacer()
              Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .font(item.amount < 10 ? .footnote : item.amount < 100 ? .subheadline : .headline)
                .foregroundStyle(item.amount < 10 ? .green : item.amount < 100 ? .yellow : .red)
            }
          }
          .onDelete(perform: removeExpenses)
        }
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

  func removeExpenses(at offsets: IndexSet) {
    for offset in offsets {
      let item = items[offset]
      modelContext.delete(item)
    }
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
              Image(systemName: item.typeImageName)
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
