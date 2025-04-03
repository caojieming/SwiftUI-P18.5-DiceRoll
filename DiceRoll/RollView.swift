//
//  RollView.swift
//  DiceRoll
//
//  Created by James Cao on 4/3/25.
//

/*
 todo:
 try to make the tabs in ContentView show separate views
 need to figure out how interactions with modelContext from different views works
 */

import SwiftUI
import SwiftData

struct RollView: View {
    @Environment(\.modelContext) var modelContext
    // dice list loaded from modelContext
    @Query(sort: \Dice.id) var die: [Dice]
    // storage path?
//    @State private var path = [Dice]()
    
    @State private var currDice = Dice(type: 6)
    let types = [4, 6, 8, 10, 12, 20, 100]
    
    var body: some View {
        NavigationStack {
            
            VStack {
                Text("Pick how many sides you want the dice to have:")
                Picker("Dice Type", selection: $currDice.type) {
                    ForEach(types, id: \.self) {
                        Text(String($0))
                    }
                }
                .pickerStyle(.segmented)
                .padding(.leading)
                .padding(.trailing)
                
                Button("Roll") {
                    currDice.roll()
                    // uncomment when history list is functional
                    //                modelContext.insert(currDice)
                }
                
                Text("\(currDice.value)")
            }
            .navigationTitle("Dice Roll")
            
        } // NavigationStack
        
    } // body
}

#Preview {
    RollView()
}
