//
//  ContentView.swift
//  HabitTracker (challenge 4)
//
//  Created by MAC on 28.07.2020.
//  Copyright © 2020 Gera Volobuev. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    
    @State private var habits = [Habit]()
    @State var showingDetail = false
    
    var body: some View {
            ZStack(alignment: .trailing) {
                VStack(alignment: .leading) {
                    Spacer(minLength: 50)
                    
                    Text("Сегодня | ")
                        .fontWeight(.bold)
                    
                    Divider()
                    
                    Spacer(minLength: 25)
                    
                    ScrollView(.vertical) {
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(0..<5) { num in
                                HStack {
                                    Button(action: {
                                        print("tap")
                                    }) {
                                        Image(systemName: "circle")
                                            .resizable()
                                            .frame(width: 35, height: 35)
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        Text("Item \(num)")
                                        
                                        Text("Item \(num)")
                                            .font(.caption)
                                            .fontWeight(.light)
                                        
                                    }
                                    
                                    Group {
                                        Image(systemName: "\(num).circle")
                                            .resizable()
                                            .frame(width: 35, height: 35)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    
                                }
                                .padding(.bottom, 15)
                                
                            }
                            
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    }
                    
                }
                
                VStack {
                    Spacer()
                    Button(action: {
                        print("tap")
                         self.showingDetail.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .foregroundColor(Color(red: 47 / 255, green: 78 / 255, blue: 251 / 255))
                    }
                    
                }
//                .offset(x: -5, y: -5)
                    .padding(.bottom, 35)
            }
                .sheet(isPresented: $showingDetail) {
                    NewHabit(showSheetView: self.$showingDetail)
                }
        
        .padding([.leading, .trailing, .top], 30)
        .background(Color(red: 245 / 255, green: 245 / 255, blue: 245 / 255))
        .edgesIgnoringSafeArea(.all)
        .foregroundColor(Color(red: 85 / 255, green: 85 / 255, blue: 85 / 255))
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
