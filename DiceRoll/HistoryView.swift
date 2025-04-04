//
//  HistoryView.swift
//  DiceRoll
//
//  Created by James Cao on 4/4/25.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    @Environment(\.modelContext) var modelContext
    // dice list loaded/queried from modelContext
//    @Query(sort: \Dice.id) var die: [Dice]
    @Query(sort: [SortDescriptor(\Dice.type), SortDescriptor(\Dice.value)]) var die: [Dice]
    
    var body: some View {
        NavigationStack {
            
            List {
                ForEach(die, id: \.self) { dice in
                    HStack {
                        Text("Dice type: \(dice.type)")
                        Spacer()
                        Text("Rolled: \(dice.value)")
                    }
                }
                .onDelete(perform: deleteDiceHist)
            }
            .navigationTitle("Roll History")
            
        } // NavigationStack
        
    } // body
    
    // for deleting an item from modelContext
    func deleteDiceHist(at offsets: IndexSet) {
        for offset in offsets {
            // find this book in our query
            let dice = die[offset]

            // delete it from the context
            modelContext.delete(dice)
        }
    }
    
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Dice.self, configurations: config)
    
    for i in 1..<10 {
        let dice = Dice(type: 10)
        dice.roll()
        container.mainContext.insert(dice)
    }
    
    return HistoryView()
        .modelContainer(container)
}
