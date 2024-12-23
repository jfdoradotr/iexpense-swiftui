//	
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import Foundation

struct ExpenseItem: Identifiable, Codable, Equatable {
  var id = UUID()
  let name: String
  let type: String
  let amount: Double
}
