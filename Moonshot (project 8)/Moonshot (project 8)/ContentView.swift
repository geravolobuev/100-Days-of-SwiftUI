//
//  ContentView.swift
//  Moonshot (project 8)
//
//  Created by MAC on 03.07.2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var toggle = true
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                    .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    .animation(.default)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        if !self.toggle {
                            Text("\(self.getCrew(mission))")
                        } else {
                            Text("\(mission.formattedLaunchDate)")
                        }
                    }
                }
            }
            
            .navigationBarItems(trailing: Button("Toggle") {
                self.toggle.toggle()
            })
        .navigationBarTitle("Moonshot")
        }
    }
    
    func getCrew(_ mission: Mission) -> String {
        var crew = [""]
        
        for member in mission.crew {
            if let match = astronauts.first(where: {
                $0.id == member.name }) {
                crew.append(match.name)
            }
        }
        return crew.joined(separator: " : ")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
