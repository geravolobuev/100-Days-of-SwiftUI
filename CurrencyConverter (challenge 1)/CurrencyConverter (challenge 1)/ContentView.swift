//
//  ContentView.swift
//  CurrencyConverter (challenge 1)
//
//  Created by MAC on 09.06.2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import SwiftUI

struct Currency: Codable {
    let rates: [String: Double]
    let base, date: String
}

struct ContentView: View {
    
    let url = "https://api.exchangeratesapi.io/latest"
    
    @State private var rate: Double = 0
    @State private var userAmount = "0"
    @State private var fromCurrency = 1
    @State private var toCurrency = 2
    let currencies = ["EUR", "USD", "RUB"]
    
    var total: Double {
        loadData()
        let amount = Double(userAmount) ?? 0
        return amount * rate
    }
    
    func loadData() {
        guard let url = URL(string: url + "?base=\(currencies[fromCurrency])") else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedData = try? JSONDecoder().decode(Currency.self, from: data) {
                    DispatchQueue.main.async {
                        self.rate = decodedData.rates[self.currencies[self.toCurrency]]!
                    }
                }
                return
            }
        }.resume()
        
    }
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Desired amount")) {
                    TextField("enter", text:$userAmount)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Choose currency")) {
                    Section(header: Text("From")) {
                        Picker("Choose currency:", selection: $fromCurrency) {
                            ForEach(0 ..< currencies.count) {
                                Text("\(self.currencies[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    Section(header: Text("To")) {
                        Picker("Choose currency:", selection: $toCurrency) {
                            ForEach(0 ..< currencies.count) {
                                Text("\(self.currencies[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
            }
        .navigationBarTitle(Text("\(total, specifier: "%.2f")"))
            .onAppear(perform: loadData)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
