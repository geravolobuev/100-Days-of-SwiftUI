//
//  ExpenseItem.swift
//  iExpense (project 7)
//
//  Created by MAC on 30.06.2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}
