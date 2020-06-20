//
//  ContentView.swift
//  WeSplit (project 1)
//
//  Created by MAC on 08.06.2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = "0"
    @State private var numberOfPeople = "2"
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalAmount: Double {
        
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        
        return grandTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 0
        let grandTotal = totalAmount
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Amount")) {
                    TextField("Enter", text: $checkAmount)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("How much tip to leave?")) {
                    Picker("Tip percentages", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Number of people")) {
                    TextField("Enter", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                
//                Section(header: Text("Total amount")) {
//
//                }
                
                Section(header: Text("Total")) {
                    Text("$\(totalAmount, specifier: "%.2f")")
                        .foregroundColor(self.tipPercentage == 4 ? .red : .black)
                    Text("$\(totalPerPerson, specifier: "%.2f") per person")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
