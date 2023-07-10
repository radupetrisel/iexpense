//
//  ContentView.swift
//  iExpense
//
//  Created by Radu Petrisel on 10.07.2023.
//

import SwiftUI

struct ContentView: View {
    private let currencyId = Locale.current.currency?.identifier ?? "USD"
    
    @StateObject private var expenses = Expenses()
    
    @State private var showingAddView = false
    
    var body: some View {
        NavigationView {
            List(Category.allCases, id: \.self) { category in
                Section(category.rawValue) {
                    ExpensesView(expenseItems: category == .personal ? expenses.personalItems : expenses.businessItems, category: category, currencyId: currencyId) { expenses.remove(category, atOffsets: $0) }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddView(expenses: expenses, currencyId: currencyId)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
