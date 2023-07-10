//
//  AddVie.swift
//  iExpense
//
//  Created by Radu Petrisel on 10.07.2023.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var type = Category.personal
    @State private var amount = 0.0

    @ObservedObject var expenses: Expenses
    let currencyId: String
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(Category.allCases, id: \.self) {
                        Text($0.rawValue.capitalized)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, category: type, value: amount)
                    expenses.append(item: item)
                    
                    dismiss()
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses(), currencyId: "USD")
    }
}
