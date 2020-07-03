//
//  ContentView.swift
//  iExpense (project 7)
//
//  Created by MAC on 29.06.2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import SwiftUI

struct Amount: View {
    var amount: Int
    
    var body: some View {
        if amount < 10 {
            return Text("$\(amount)")
                .foregroundColor(Color.green)
        } else if amount < 100 {
           return Text("$\(amount)")
            .foregroundColor(Color.yellow)
        } else {
           return Text("$\(amount)")
            .foregroundColor(Color.red)
        }
    }
}

struct ContentView: View {
    
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpenses = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        Amount(amount: item.amount)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpenses")
            .navigationBarItems(leading: EditButton(), trailing:
                Button(action: {
                    self.showingAddExpenses = true
                }) {
                    Image(systemName: "plus")
            })
            
        }
        .sheet(isPresented: $showingAddExpenses) {
            AddView(expenses: self.expenses)
        }
    }
    func removeItems(at offsets: IndexSet) {
           expenses.items.remove(atOffsets: offsets)
    }

    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
