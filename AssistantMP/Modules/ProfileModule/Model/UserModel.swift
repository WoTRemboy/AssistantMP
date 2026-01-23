//
//  UserModel.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 23/01/2026.
//

import Foundation

struct User: Hashable, Identifiable {
    let id: UUID = .init()
    let name: String
    let level: Int
    let currentXP: Int
    let maxXP: Int
    let bank: Int
    let cash: Int

    internal var xpProgress: Double {
        let progress = Double(currentXP) / Double(maxXP)
        return min(max(progress, 0), 1)
    }
    
    static internal var sample: User {
        .init(name: "John Doe",
              level: 25,
              currentXP: 12_450,
              maxXP: 15_000,
              bank: 125_750,
              cash: 25_750)
    }
}
