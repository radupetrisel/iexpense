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
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.category)
                        }
                        
                        Spacer()
                        
                        Text(item.value, format: .currency(code: currencyId))
                            .fontWeight(.light)
                            .foregroundColor(getForeground(for: item.value))
                    }
                }
                .onDelete(perform: remove(atOffsets:))
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
    
    private func remove(atOffsets offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
