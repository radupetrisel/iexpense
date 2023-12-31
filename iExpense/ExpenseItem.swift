//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Radu Petrisel on 10.07.2023.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    
    let name: String
    let category: Category
    let value: Double
}

enum Category: String, CaseIterable, Codable {
    case personal, business
}
