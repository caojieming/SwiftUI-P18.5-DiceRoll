//
//  RollView.swift
//  DiceRoll
//
//  Created by James Cao on 4/3/25.
//

import SwiftUI
import SwiftData

struct RollView: View {
    @Environment(\.modelContext) var modelContext
    // dice list loaded/queried from modelContext
//    @Query var die: [Dice]
    
    let types = [4, 6, 8, 10, 12, 20, 100]
    @State private var diceType = 6
    @State private var curDiceVal = 0
    
    var body: some View {
        NavigationStack {
            
            VStack {
                Text("Pick how many sides you want the dice to have:")
                Picker("Dice Type", selection: $diceType) {
                    ForEach(types, id: \.self) {
                        Text(String($0))
                    }
                }
                .pickerStyle(.segmented)
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom)
                
                Button("Roll") {
                    let newDiceRoll = Dice(type: diceType)
                    curDiceVal = newDiceRoll.value
//                    print("roll type, val: \(newDiceRoll.type), \(newDiceRoll.value)")
                    modelContext.insert(newDiceRoll)
//                    print("die: \(die)")
                }
                .padding()
                .font(.title)
                
                Text("\(curDiceVal)")
                    .padding()
                    .font(.title)

            }
            .navigationTitle("Dice Roll")
            
        } // NavigationStack
        
    } // body
    
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Dice.self, configurations: config)
    return RollView()
        .modelContainer(container)
}
