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
    
    let diceTypeOptions = [4, 6, 8, 10, 12, 20, 100]
    @State private var diceType = 6
    
    let numDieOptions = [1, 2, 3, 4, 5, 6]
    @State private var numDie = 1
    
    @State private var curDieVals = [0]
    
    var body: some View {
        NavigationStack {
            
            VStack {
                Text("Pick how many sides you want the dice to have:")
                Picker("Dice Type", selection: $diceType) {
                    ForEach(diceTypeOptions, id: \.self) {
                        Text(String($0))
                    }
                }
                .pickerStyle(.segmented)
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom)
                
                Text("Pick how many die you want to roll:")
                Picker("Number of Die", selection: $numDie) {
                    ForEach(numDieOptions, id: \.self) {
                        Text(String($0))
                    }
                }
                .pickerStyle(.segmented)
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom)
                
                // roll button
                Button("Roll") {
                    // clears out curDieVals
                    curDieVals.removeAll()
                    
                    // generate a total of "numDie" vals
                    for _ in 1...numDie {
                        let newDiceRoll = Dice(type: diceType)
                        curDieVals.append(newDiceRoll.value)
                        modelContext.insert(newDiceRoll)
                    }
                }
                .padding()
                .font(.title)
                .sensoryFeedback(.increase, trigger: curDieVals)
                
                // rolled die results
                ScrollView {
                    LazyHStack {
                        ForEach(Array(curDieVals.enumerated()), id: \.offset) { index, item in
                            Text("\(item)")
                        }
                        .listStyle(.plain)
                        .padding()
                        .font(.title2)
                    }
                }
                
                // rolled die results total sum
                Text("Total sum: \(curDieVals.reduce(0, +))")
                    .padding()
                    .font(.title2)
                
                Spacer()
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
