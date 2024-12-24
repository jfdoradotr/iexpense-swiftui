//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftData
import SwiftUI

struct ContentView: View {
  @State private var sortOrder = [
    SortDescriptor(\Expense.name),
    SortDescriptor(\Expense.amount)
  ]

  var body: some View {
    NavigationStack {
      ExpensesView(sortOrder: sortOrder)
        .navigationTitle("iExpense")
        .toolbar {
          Menu {
            Picker("Sort", selection: $sortOrder) {
              Text("Sort by Name")
                .tag([
                  SortDescriptor(\Expense.name),
                  SortDescriptor(\Expense.amount)
                ])
              Text("Sort by Amount")
                .tag([
                  SortDescriptor(\Expense.amount),
                  SortDescriptor(\Expense.name)
                ])
            }
          } label: {
            Label("Sort", systemImage: "arrow.up.arrow.down")
          }
          NavigationLink {
            AddView()
          } label: {
            Image(systemName: "plus")
          }
        }
    }
  }


}

// MARK: - SectionView

private extension ContentView {
  struct ExpensesView: View {
    @Environment(\.modelContext) var modelContext

    @Query var expenses: [Expense]

    var body: some View {
      List {
        Section {
          ForEach(expenses) { expense in
            HStack {
              VStack(alignment: .leading) {
                Text(expense.name)
                  .font(.headline)
                Image(systemName: expense.typeImageName)
                  .font(.subheadline)
              }
              Spacer()
              Text(expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .font(expense.amount < 10 ? .footnote : expense.amount < 100 ? .subheadline : .headline)
                .foregroundStyle(expense.amount < 10 ? .green : expense.amount < 100 ? .yellow : .red)
            }
          }
          .onDelete(perform: removeExpenses)
        }
      }
    }

    init(sortOrder: [SortDescriptor<Expense>]) {
      _expenses = Query(sort: sortOrder)
    }

    private func removeExpenses(at offsets: IndexSet) {
      for offset in offsets {
        let expense = expenses[offset]
        modelContext.delete(expense)
      }
    }
  }
}

// MARK: - Previews

#Preview {
  ContentView()
}
