//
//  Activity.swift
//  13_Milestone03(7-9)_HabitsTracker
//
//  Created by Jacob Zhang on 2020/5/3.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import Foundation

struct Activity: Identifiable, Codable {

    let id = UUID()

    var title: String {
        didSet { date = Date() }
    }

    var description: String {
        didSet { date = Date() }
    }

    /// last modification date
    var date = Date()

    var completedTimes: Int = 0 {
        didSet {
            date = Date()
            if completedTimes < 0 {
                completedTimes = 0
            }
        }
    }
}
