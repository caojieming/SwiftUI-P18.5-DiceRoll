//
//  Dice.swift
//  DiceRoll
//
//  Created by James Cao on 4/3/25.
//

import SwiftUI
import SwiftData

@Model
class Dice {
    // unique ID for record keeping
    var id: UUID
    // what type of dice: n-sided dice
    var type: Int
    // value that was rolled
    var value: Int
    
    init(id: UUID = UUID(), type: Int) {
        self.id = id
        self.type = type
        self.value = Int.random(in: 1..<(type + 1))
//        self.value = 0
    }
    
    func roll() {
        value = Int.random(in: 1..<(type + 1))
    }
    
//    func getVal() -> Int {
//        return value
//    }
    
}
