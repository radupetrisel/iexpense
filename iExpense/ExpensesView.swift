//
//  ExpensesView.swift
//  iExpense
//
//  Created by Radu Petrisel on 10.07.2023.
//

import SwiftUI

struct ExpensesView: View {
    let expenseItems: [ExpenseItem]
    let category: Category
    let currencyId: String
    let onDelete: (IndexSet) -> Void
    
    var body: some View {
        ForEach(expenseItems) { item in
            HStack {
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                    Text(item.category.rawValue)
                }
                
                Spacer()
                
                Text(item.value, format: .currency(code: currencyId))
                    .fontWeight(.light)
                    .foregroundColor(getForeground(for: item.value))
            }
        }
        .onDelete(perform: onDelete)
    }
    
    private func getForeground(for amount: Double) -> Color {
        if amount < 10 {
            return .green
        }
        
        if amount < 100 {
            return .primary
        }
        
        return .red
    }
}

struct ExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesView(expenseItems: [], category: .personal, currencyId: "USD") { _ in }
    }
}
