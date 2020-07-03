//
//  ContentView.swift
//  GuessTheFlag (project 2)
//
//  Created by MAC on 10.06.2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import SwiftUI

struct FlagImage: View {
    
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var score = 0
    @State private var animationAmount = 0.0
    @State private var opacityAmount = 1.0
    @State private var overlayLineWidth: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.black, .gray]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                
                Spacer()
                
                VStack {
                    Text("Tap the flag of")
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                .foregroundColor(.white)
                
                
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                        
                    }) {
                        FlagImage(imageName: self.countries[number])
                    }
                    .rotation3DEffect(.degrees(number == self.correctAnswer ? self.animationAmount : 0), axis: (x: 0, y: 1, z: 0))
                    .opacity(number != self.correctAnswer ? self.opacityAmount : 1)
                    .overlay(Capsule().stroke(number != self.correctAnswer ? Color.red : Color.green, lineWidth: self.overlayLineWidth))
                    
                }
                
                Text("Current score: \(score)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Spacer()
            }
        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            withAnimation {
                self.animationAmount += 360
                self.opacityAmount = 0.25
            }
            self.score += 1
            
        } else {
            self.score -= 1
            withAnimation {
                self.overlayLineWidth = 15
            }

        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.askQuestion()
        }

    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ... 2)
        withAnimation {
            opacityAmount = 1
            overlayLineWidth = 0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
