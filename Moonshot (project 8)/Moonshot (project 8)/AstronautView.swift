//
//  AstronautView.swift
//  Moonshot (project 8)
//
//  Created by MAC on 07.07.2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import Foundation
import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var participated: [Mission] {
        var matches = [Mission]()
        
        for mission in self.missions {
            for crew in mission.crew {
                if crew.name == astronaut.id {
                    matches.append(mission)
                }
            }
            
        }
        return matches
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                        
                    
                    Group {
                        Text(self.astronaut.description)
                            .layoutPriority(1)
                        
                        Text("Participated in missions:")
                            .font(.headline)
                            
                        VStack {
                            ForEach(self.participated) {
                                
                                Image($0.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 44, height: 44)
                                    .animation(.default)
                                
                                Text($0.displayName)
                                    .font(.headline)
                                Text("\($0.formattedLaunchDate)")
                            }
                        }
                    }
                    .padding()
                    
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
        .edgesIgnoringSafeArea(.all)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[13])
    }
}
