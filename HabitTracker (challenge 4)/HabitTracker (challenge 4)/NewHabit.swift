//
//  NewHabit.swift
//  HabitTracker (challenge 4)
//
//  Created by MAC on 29.07.2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import SwiftUI

struct ExDivider: View {
    let color: Color = .black
    let width: CGFloat = 2
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}


struct NewHabit: View {
    
    @State private var habit = ""
    @Binding var showSheetView: Bool
    
    var body: some View {
        VStack(alignment: .trailing) {
            
            Button(action: {
                print("tap")
                self.showSheetView = false
            }) {
                Image(systemName: "xmark")
            }
            .foregroundColor(.black)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 0) {
                Text("21 день")
                Text("я буду")
                TextField("делать что то...", text: $habit)
                    .autocapitalization(.none)
                ExDivider()
                
                Text("каждый день")
            }
            
            Spacer()
            
            
            Button("начать") {
                print("tap")
                self.showSheetView = false
            }
                
            .frame(maxWidth: .infinity)
            .background(Color(red: 47/255, green: 78/255, blue: 251/255))
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color(red: 47/255, green: 78/255, blue: 251/255), lineWidth: 5))
            .foregroundColor(.white)
            .shadow(color: .gray, radius: 15.0, x: 5.0, y: 15.0)
        }
        .font(.largeTitle)
        .padding(50)
        .background(Color(red: 245 / 255, green: 245 / 255, blue: 245 / 255))
        .edgesIgnoringSafeArea(.all)
    }
}

//struct NewHabit_Previews: PreviewProvider {
//    static var previews: some View {
//        NewHabit()
//    }
//}
