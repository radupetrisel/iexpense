//
//  Expenses.swift
//  iExpense
//
//  Created by Radu Petrisel on 10.07.2023.
//

import Foundation

class Expenses: ObservableObject {
    private static let itemsKey = "items"
    
    @Published var items: [ExpenseItem] {
        didSet {
            if let data = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(data, forKey: Self.itemsKey)
            }
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: Self.itemsKey) {
            if let items = try? JSONDecoder().decode([ExpenseItem].self, from: data) {
                self.items = items
                return
            }
        }
        
        self.items = []
    }
}
