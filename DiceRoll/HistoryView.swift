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
    // dice list loaded/queried from modelContext, sorted by type then value
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
//            .toolbar {
//                Button("Clear all") {
//                    clearHist()
//                }
//            }
            
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
    
    // clear all items (nonfunctional)
//    func clearHist() {
//        do {
//            try modelContext.delete(model: Dice.self)
//        } catch {
//            print("Failed to clear all dice data.")
//        }
//    }
    
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Dice.self, configurations: config)
    
    for _ in 1...10 {
        let dice = Dice(type: 10)
        dice.roll()
        container.mainContext.insert(dice)
    }
    
    return HistoryView()
        .modelContainer(container)
}
