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
    var body: some View {
        
        TabView {
            RollView()
                .tabItem {
                    Label("Dice Roll", systemImage: "cube")
                }
            
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "line.horizontal.3")
                }
        }
    } // body
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Dice.self, configurations: config)
    
    return ContentView()
        .modelContainer(container)
}
