//
//  RockPaperScissors.swift
//  05_Milestone01(1-3)_RockPaperScissors
//
//  Created by Jacob Zhang on 2020/4/30.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import Foundation

class RockPaperScissors: ObservableObject {
    @Published var gesture = Gesture.allCases.randomElement()!
    @Published var goal = Goal.allCases.randomElement()!

    private var timer: Timer?
    private static let maxTime = 5.0
    @Published var remainingTime = RockPaperScissors.maxTime

    @Published var score = 0 {
        didSet {
            newQuestion()
        }
    }

    @Published var mode: Mode = .normal {
        didSet {
            switch mode {
            case .normal:
                timer?.invalidate()
                timer = nil
            case .timed:
                remainingTime = RockPaperScissors.maxTime
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                    // 由于这个原因，RockPaperScissorss 只能使用类，不能使用结构体（在结构体中不需要使用 ObservableObject, @Published，可以使用 @State 来代替 @ObservedObject）；updateTime() 是要更新的，而在结构体中，Timer 只会产生一个本身（self）的副本，而不能改变原始的结构体
                    self?.updateRemainingTime()
                }
            }
            newQuestion()
        }
    }

    deinit {
        timer?.invalidate()
        timer = nil
    }

    func submitAnswer(withGuess guess: Gesture) {
        switch mode {
        case .normal:
            score += isCorrect(guess: guess) ? 1 : -1
        case .timed:
            score += remainingTime > 0 && isCorrect(guess: guess) ? 1 : -1
        }
    }

    private func updateRemainingTime() {
        if mode == .timed {
            remainingTime -= 1

            if remainingTime <= 0 {
                score -= 1
            }
        }
    }

    private func newQuestion() {
        gesture = Gesture.allCases.randomElement()!
        goal = Goal.allCases.randomElement()!

        if mode == .timed {
            remainingTime = RockPaperScissors.maxTime
        }
    }

    private func isCorrect(guess: Gesture) -> Bool {
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
