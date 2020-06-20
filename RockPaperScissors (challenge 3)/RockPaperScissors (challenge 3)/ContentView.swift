//
//  ContentView.swift
//  RockPaperScissors (challenge 3)
//
//  Created by MAC on 15.06.2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import SwiftUI

struct GameButton: View {
    
    var imageName: String
    
    var body: some View {
        Image("\(imageName)")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
    }
}

struct ContentView: View {
    
    @State private var score = 0
    @State private var computerChoice = Int.random(in: 0..<3)
    @State private var playerShouldWin = Bool.random()
    @State private var userChoice = 0
    
    let moves = ["rock", "paper", "scissors"]
    
    var body: some View {
        VStack {
            Spacer()
            Text("Score: \(score)")
                .font(.largeTitle)
            Spacer()
            
            Group {
                Text("Computer choosed:")
                    .foregroundColor(.gray)
                GameButton(imageName: "\(moves[computerChoice])")
            }
            
            Spacer()
            Group {
                Text(playerShouldWin ? "You should win" : "You should loose")
                    .font(.largeTitle)
                    .foregroundColor(playerShouldWin ? .green : .red)
            }
            
            Spacer()
            
            Group {
                Text("You choose?")
                    .foregroundColor(.gray)
                HStack {
                    ForEach(0 ..< moves.count) { move in
                        Button(action: {
                            self.userChoice = move
                            self.checkAnswer()
                        }) {
                            GameButton(imageName: self.moves[move])
                        }
                    }
                }
            }
            Spacer()
        }
    }
    
    func makeMove() {
        playerShouldWin = Bool.random()
        computerChoice = Int.random(in: 0 ..< 3)
        
    }
    
    func checkAnswer() {
        if (userChoice + 1) % 3 == computerChoice || userChoice == computerChoice {
            print("PC wins!")
            score += !playerShouldWin ? 1 : 0
        } else {
            score += playerShouldWin ? 1 : 0
            print("Player wins!")
        }
        makeMove()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
