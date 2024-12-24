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
  @State private var viewBy: ExpensesView.ViewBy = .all

  var body: some View {
    NavigationStack {
      ExpensesView(sortOrder: sortOrder, viewBy: viewBy)
        .navigationTitle("iExpense")
        .toolbar {
          Menu {
            Menu {
              Picker("Sort", selection: $sortOrder) {
                Text("By Name")
                  .tag([
                    SortDescriptor(\Expense.name),
                    SortDescriptor(\Expense.amount)
                  ])
                Text("By Amount")
                  .tag([
                    SortDescriptor(\Expense.amount),
                    SortDescriptor(\Expense.name)
                  ])
              }
            } label: {
              Label("Sort", systemImage: "arrow.up.arrow.down")
            }
            Menu {
              Picker("View", selection: $viewBy) {
                Text("All")
                  .tag(ExpensesView.ViewBy.all)
                Text("Personal")
                  .tag(ExpensesView.ViewBy.personal)
                Text("Business")
                  .tag(ExpensesView.ViewBy.business)
              }
            } label: {
              Label("View", systemImage: "eye.fill")
            }
          } label: {
            Label("Sort", systemImage: "slider.horizontal.3")
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

    enum ViewBy: String, CaseIterable {
      case all = "All"
      case personal = "Personal"
      case business = "Business"
    }

    var body: some View {
      List {
        Section {
          ForEach(expenses) { expense in
            HStack {
              VStack(alignment: .leading, spacing: 5) {
                Text(expense.name)
                  .font(.headline)
                HStack {
                  Image(systemName: expense.typeImageName)
                  Text(expense.type)
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
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

    init(sortOrder: [SortDescriptor<Expense>], viewBy: ViewBy) {
      let filter: Predicate<Expense>
      switch viewBy {
      case .all:
        filter = #Predicate<Expense> { _ in true }
      case .personal:
        filter = #Predicate<Expense> { expense in expense.type == "Personal" }
      case .business:
        filter = #Predicate<Expense> { expense in expense.type == "Business" }
      }
      _expenses = Query(
        filter: filter,
        sort: sortOrder
      )
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
