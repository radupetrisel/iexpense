//
//  Expenses.swift
//  iExpense
//
//  Created by Radu Petrisel on 10.07.2023.
//

import Foundation

class Expenses: ObservableObject {
    private static let personalItems = "personalItems"
    private static let businessItems = "businessItems"
    
    @Published private(set) var personalItems = [ExpenseItem]() {
        didSet {
            save(items: personalItems, key: Self.personalItems)
        }
    }
    @Published private(set) var businessItems = [ExpenseItem]() {
        didSet {
            save(items: businessItems, key: Self.businessItems)
        }
    }
    
    init() {
        load(items: &personalItems, key: Self.personalItems)
        load(items: &businessItems, key: Self.businessItems)
    }
    
    func append(item: ExpenseItem) {
        switch item.category {
        case .personal:
            personalItems.append(item)
        case .business:
            businessItems.append(item)
        }
    }
    
    func remove(_ category: Category, atOffsets offsets: IndexSet) {
        switch category {
        case .personal:
            personalItems.remove(atOffsets: offsets)
        case .business:
            businessItems.remove(atOffsets: offsets)
        }
    }
    
    private func load(items: inout [ExpenseItem], key: String) {
        if let data = UserDefaults.standard.data(forKey: key) {
            if let newItems = try? JSONDecoder().decode([ExpenseItem].self, from: data) {
                items = newItems
            }
        }
    }
    
    private func save(items: [ExpenseItem], key: String) {
        if let data = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
