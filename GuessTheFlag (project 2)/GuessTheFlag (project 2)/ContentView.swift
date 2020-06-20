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
    
    @State private var isShowing = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
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
                }
                
                Text("Current score: \(score)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Spacer()
            }
        }
        .alert(isPresented: $isShowing) {
            Alert(title: Text(self.scoreTitle), message: Text("Your score is: \(self.score)"), dismissButton: .default(Text("Ok")) {
                self.askQuestion()
                })
        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            self.scoreTitle = "Correct!"
            self.score += 1
        } else {
            self.scoreTitle = "Wrong! Thats the flag of \(self.countries[number])"
            self.score -= 1
        }
        isShowing = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ... 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
