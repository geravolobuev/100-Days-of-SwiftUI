//
//  ContentView.swift
//  Animations (project 6)
//
//  Created by MAC on 21.06.2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}

struct ContentView: View {
    let questionAmount = ["5", "10" , "20", "all"]
    
    var body: some View {
        
            VStack {
                ForEach(1..<4) {_ in
                    HStack {
                        ForEach(1..<4) { num in
                            Button(action: {
                                print("G")
                            }) {
                                Image(systemName: "\(num).circle")
                            }
                        }
                    }
                }
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}
