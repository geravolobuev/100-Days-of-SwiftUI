//
//  ContentView.swift
//  MultiplicationTables (challenge 3)
//
//  Created by MAC on 26.06.2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import SwiftUI

extension UIScreen {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
}

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    
    func body(content: Content) -> some View {
        content.rotationEffect(Angle(degrees: amount)).animation(
            Animation.easeInOut(duration: 2)
                .repeatForever(autoreverses: true)
        )
    }
}

struct Animal: View {
    let animalName: String
    
    var body: some View {
        Image(animalName)
            .resizable()
            .rotationEffect(Angle(degrees: -60.0))
            .frame(width: 100, height: 80, alignment: .center)
            .padding()
    }
}


struct ContentView: View {
    
    let animals = ["bear", "panda", "frog", "dog", "monkey", "pig"]
    
    @State private var rotationAmount = 0.0
    @State private var pulseAmount: CGFloat = 1
    
    @State private var isConfigured = false
    @State private var isTablesChosed = false
    @State private var isGameOver = true
    
    let questionAmount = ["5", "10" , "20", "100"]
    @State private var questionAmountChoice = ""
    @State private var tables = 2
    
    @State private var question = ""
    @State private var answer = 0
    @State private var userAnswer = ""
    
    @State private var scoreCorrect = 0
    @State private var scoreFail = 0
    @State private var totalQuestionsAsked = 0
    
    var body: some View {
        NavigationView {
            
            ZStack {
                Image("background")
                    .resizable()
                VStack {
                    HStack {
                        Animal(animalName: self.animals[Int.random(in: 0..<2)])
                            .modifier(CornerRotateModifier(amount: rotationAmount))
                        Spacer()
                        Animal(animalName: self.animals[Int.random(in: 2..<4)])
                            .modifier(CornerRotateModifier(amount: rotationAmount))
                    }
                    
                    Spacer()
                    
                    ZStack {
                        VStack {
                            if !isGameOver {
                            if isConfigured {
                                // GAME
                                Group {
                                    Text("How much is:")
                                    Text("\(question)")
                                        .foregroundColor(Color.yellow)
                                        .fontWeight(.black)
                                }
                                
                                Group {
                                    TextField("Answer", text: $userAnswer, onCommit: self.checkAnswer)
                                }
                                .multilineTextAlignment(TextAlignment.center)
                                .frame(width: 150, height: 100, alignment: .center)
                                .background(Color.yellow)
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.white, lineWidth: 5))
                                .shadow(color: .gray, radius: 5)
                                .scaleEffect(pulseAmount)
                                .animation(
                                    Animation.easeOut(duration: 1)
                                        .repeatForever(autoreverses: true)
                                )
                                
                                // CONFIGURATION
                            } else {
                                
                                if !isTablesChosed {
                                    
                                    Text("Choose table:")
                                        .padding()
                                        .font(.title)
                                    Group {
                                        HStack {
                                            ForEach(2..<10) { num in
                                                Button("\(num)") {
                                                    self.tables = num
                                                    self.isTablesChosed.toggle()
                                                }
                                            }
                                        }
                                        .background(Color.yellow)
                                        .foregroundColor(Color.blue)
                                        Button("choose all") {
                                            self.tables = 0
                                            self.isTablesChosed.toggle()
                                        }
                                    }
                                    
                                } else {
                                    
                                    Text("How much questions?")
                                    HStack {
                                        ForEach(questionAmount, id: \.self) { amount in
                                            Button(amount) {
                                                self.questionAmountChoice = amount
                                                self.isConfigured.toggle()
                                                self.askQuestion()
                                            }
                                            .padding()
                                        }
                                    }
                                    .foregroundColor(Color.blue)
                                    .background(Color.yellow)
                                }
                            }
                            } else {
                                            VStack {
                                    Spacer()
                                    Text("Congratulations!")
                                    Spacer()
                                    Group {
                                    Text("You scored:")
                                    Text("\(scoreCorrect) correct ones")                    .foregroundColor(Color.green)
                                    Text("And failed \(scoreFail) times")
                                        .foregroundColor(Color.red)
                                    }
                                    Spacer()
                                    Group {
                                    if scoreFail < scoreCorrect {
                                        Text("Good job!")
                                    } else {
                                        Text("Not bad! Keep practicing!")
                                    }
                                    }
                                    Spacer()
                                    Button("Play more") {
                                        print("Start")
                                    }
                                    .foregroundColor(Color.yellow)
                                    .font(.largeTitle)
                                    Spacer()
                                }
                                            .font(.title)
                            }
                        }
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                        .padding()
                        
                    }
                    
                    Spacer()
                    
                    HStack {
                        Animal(animalName: self.animals[Int.random(in: 4..<6)])
                            .modifier(CornerRotateModifier(amount: rotationAmount))
                        Spacer()
                        if isConfigured {
                            VStack {
                                HStack {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(Color.green)
                                    Text("\(scoreCorrect)")
                                }
                                HStack {
                                    Image(systemName: "xmark")
                                        .foregroundColor(Color.red)
                                    Text("\(scoreFail)")
                                }
                            }
                            .font(.largeTitle)
                        }
                        
                        Spacer()
                        
                        Animal(animalName: self.animals[Int.random(in: 0..<3)])
                            .modifier(CornerRotateModifier(amount: rotationAmount))
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            .animation(.default)
            .onAppear(perform: {
                self.rotationAmount += 120
                self.pulseAmount = 1.1
            })
        }
    }
    
    func startAgain() {
        isGameOver = false
        isConfigured = false
        isTablesChosed = false
        totalQuestionsAsked = 0
        scoreFail = 0
        scoreCorrect = 0
    }
    
    func checkAnswer() {
        guard let questionsAmount = Int(questionAmountChoice) else { return }
        if questionsAmount != totalQuestionsAsked {
            
            if let answer = Int(userAnswer) {
                if answer == self.answer {
                    scoreCorrect += 1
                } else {
                    scoreFail += 1
                }
                askQuestion()
            }
            
        } else {
            isGameOver = true
        }
        
    }
    
    func askQuestion() {
        
        let a = Int.random(in: 1..<13)
        var b = tables
        if b == 0 {
            b = Int.random(in: 1..<13)
        }
        self.question = "\(a) * \(b)"
        self.answer = a * b
        self.totalQuestionsAsked += 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

