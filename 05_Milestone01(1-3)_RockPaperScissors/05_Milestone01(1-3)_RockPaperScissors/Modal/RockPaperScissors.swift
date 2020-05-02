//
//  RockPaperScissors.swift
//  05_Milestone01(1-3)_RockPaperScissors
//
//  Created by Jacob Zhang on 2020/4/30.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import Foundation

struct RockPaperScissors {
    var gesture: Gesture = Gesture.allCases.randomElement()!
    var goal = Goal.allCases.randomElement()!

    func isCorrect(guess: Gesture) -> Bool {
        switch goal {
        case .win:
            return isWinner(guess, over: gesture)
        case .lose:
            return isWinner(gesture, over: guess)
        }
    }

    private func isWinner(_ shouldWin: Gesture, over shouldLose: Gesture) -> Bool {
        switch shouldWin {
        case .rock:
            return shouldLose == .scissors
        case .paper:
            return shouldLose == .rock
        case .scissors:
            return shouldLose == .paper
        }
    }
}
