//
//  ContentView.swift
//  Drawing (project 9)
//
//  Created by MAC on 10.07.2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import SwiftUI

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(self.color(for: value, brightness: 1), lineWidth: 2)
            }
        }
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct Arrow: Shape {
    
    var amount: CGFloat
    
    var animatableData: CGFloat {
        get { amount }
        set { self.amount = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        
        path.move(to: CGPoint(x: rect.minX + 50, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX - 50, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX - 50, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX + 50, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX + 50, y: rect.maxY))
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        
        return path
    }
}

struct ContentView: View {
    
    @State private var amount: CGFloat = 1
    @State private var colorCycle = 0.0
    var body: some View {
        VStack {
            GeometryReader { geo in
                Arrow(amount: self.amount)
                    .stroke(lineWidth: self.amount)
                    .frame(width: geo.size.width / 2, height: geo.size.height / 2)
                    .foregroundColor(.red)
                    .onTapGesture {
                        withAnimation {
                            self.amount = CGFloat.random(in: 1...50)
                        }
                }
                
            }
            ColorCyclingCircle(amount: self.colorCycle)
                .frame(width: 300, height: 300)

            Slider(value: $colorCycle)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
