# iExpense

A SwiftUI application to manage personal and business expenses, built as part of the **100 Days of SwiftUI** challenge.

## Features

- **Expense Tracking**: Add, view, and categorize expenses as Personal or Business.
- **Custom Styling**: Expense amounts are styled based on value thresholds:
  - Under $10: Green and small font.
  - $10 to $100: Yellow and medium font.
  - Over $100: Red and large font.
- **UserDefaults Integration**: Persistent storage using `UserDefaults` to save and load expenses.
- **Sheet Management**: Intuitive modal interface for adding new expenses.
- **Dynamic Currency**: Automatically formats amounts based on the user's preferred currency.
- **Sectioned Lists**: Expenses are displayed in separate sections for Personal and Business items.
- **Data Deletion**: Remove items with a swipe gesture.

## Key Learnings

### Using `@State` with Classes

- Using `@State` with a class differs from using it with a struct:
  - **Structs**: When a property changes, the whole struct and the body are recreated.
  - **Classes**: Only the changed value is updated, not the entire view body.
- To make SwiftUI track changes in classes, use the `@Observable` macro.

  ```swift
  @Observable
  class User {
    var firstName = "Juan"
    var lastName = "Dorado"
  }
  ```

### Sharing SwiftUI State with `@Observable`

- `@Observable` is part of the Observation framework (no import needed unless you want to expand macros).
- In structs, `@State` keeps the object alive and watches for changes.
- In classes, `@State` only keeps the object alive, and `@Observable` handles state observation.

### Showing and Hiding Views

- Sheets are a simple and effective way to present modal views in SwiftUI.

### Deleting Items Using `onDelete()`

- The `onDelete()` modifier works only with `ForEach` and requires an `IndexSet`, which is an ordered array, to specify items to delete.

### Storing User Settings with `UserDefaults`

- A simple way to persist data between app launches.
- Best for small datasets (under 512 KB) to maintain performance.
- SwiftUI provides `@AppStorage` as a convenient property wrapper for UserDefaults integration.
  - Note: As of iOS 17, `@AppStorage` isn't ideal for storing complex data types such as structs.

### Archiving Swift Objects with `Codable`

- `Codable` simplifies encoding and decoding of data.
- All properties in a struct/class must conform to the `Codable` protocol.
- `Codable` automatically generates boilerplate code for encoding/decoding behind the scenes.

## Challenges Implemented

1. Used the user's preferred currency rather than always defaulting to USD.
2. Styled expense amounts based on their value:
   - Green for amounts under $10.
   - Yellow for amounts between $10 and $100.
   - Red for amounts over $100.
3. Split the expenses list into two sections: Personal and Business, with separate deletion handling for each.

## Code Overview

The project includes an `Observable` class (`Expenses`) for managing the expense list and a `ContentView` that implements the main UI. Below are some key components:

- **ExpenseItem**: A model conforming to `Identifiable` and `Codable` for each expense.
- **Expenses Class**: Manages a list of expenses, stored persistently using `UserDefaults` and separated into personal and business items.
- **ContentView**: Displays the expenses in a sectioned list with add/delete functionality.
- **AddView**: A sheet view for adding new expenses.

---

This project has been a great way to solidify knowledge of SwiftUI's core concepts while building a functional and extendable app. 🚀
