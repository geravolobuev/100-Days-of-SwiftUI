//
//  ContentView.swift
//  ViewsAndModifiers (project 3)
//
//  Created by MAC on 11.06.2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import SwiftUI

// Custom modifier example
struct LargeBlueFont: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(Color.blue)
    }
}

// In order to use this modifier without '.modifier()' parameter we could write extension to View
extension View {
    func largeBlueFont() -> some View {
        self.modifier(LargeBlueFont())
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
            Text("Hello, World!")
            Text("Hello, World!")
            Text("Hello, World!")
        }
    .largeBlueFont()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
