//
//  Roll.swift
//  25_Milestone06(16-18)_RollTheDice
//
//  Created by Jacob Zhang on 2020/5/12.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import Foundation

/// A roll and its result
struct Roll: Identifiable {
    var id = UUID()

    /// Number of sides of each dice
    var diceSides: Int

    /// Result or the roll, as an array of side values
    var result: [Int]

    /// Sum of the roll
    var total: Int
}
