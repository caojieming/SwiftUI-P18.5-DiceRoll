//
//  ContentView.swift
//  DiceRoll
//
//  Created by James Cao on 4/2/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    // dice list loaded from modelContext
    @Query(sort: \Dice.id) var die: [Dice]
    // storage path?
//    @State private var path = [Dice]()
    
    var body: some View {
        
        TabView {
            RollView()
                .tabItem {
                    Label("One", systemImage: "star")
                }
            
            Text("Tab 2")
                .tabItem {
                    Label("Two", systemImage: "circle")
                }
        }
        
    } // body
}

#Preview {
    ContentView()
}
