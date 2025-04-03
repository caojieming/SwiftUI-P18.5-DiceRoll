//
//  DiceRollApp.swift
//  DiceRoll
//
//  Created by James Cao on 4/2/25.
//

import SwiftUI

@main
struct DiceRollApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Dice.self)
    }
}
