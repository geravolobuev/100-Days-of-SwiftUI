//
//  Habit.swift
//  HabitTracker (challenge 4)
//
//  Created by MAC on 28.07.2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import Foundation

struct Habit: Codable, Identifiable {
    let id = UUID()
    let habit: String
    let date: Date
}
