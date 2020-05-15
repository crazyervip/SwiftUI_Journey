//
//  DiceAnimatableModifier.swift
//  25_Milestone06(16-18)_RollTheDice
//
//  Created by Jacob Zhang on 2020/5/12.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct DiceConstants {
    static let numberFrameHeight: CGFloat = 40

    static let slotFrameHeight = numberFrameHeight * 3
    static let slotFrameWidth: CGFloat = 61

    static let minimumScrollingNumbers = 200
}

enum DiceStyle {
    case normal, wheel
}

// Great introduction to AnimatableModifier: https://swiftui-lab.com/swiftui-animations-part3/

struct DiceAnimatableModifier: AnimatableModifier {
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    // MARK:- Parameters

    /// Dice sides
    var sides: Int

    /// Source side to animate from
    var source: Int

    /// Target side to animate to
    var target: Int

    /// Animation percentage
    var percent: Double

    /// True when animation is complete
    @Binding var complete: Bool

    var animatableData: Double {
        get { percent }
        set { percent = newValue }
    }

    // MARK:- Private properties

    private let style: DiceStyle = .normal

    // 0 to 1, 0 being no effect, 1 maximum effect
    private let wheelStyleStrength: Double = 0.5

    private var wheelMaskColor: Color {
        colorScheme == .light ?
            Color.gray :
            Color(red: 0.2, green: 0.2, blue: 0.2)
    }

    // MARK:- View

    func body(content: Content) -> some View {
        let repeats = Double(DiceConstants.minimumScrollingNumbers / sides)

        let absoluteNumber: Double =
            // start at 1 instead of 0
            1.0 +
            // scroll for at least a minimum of numbers
            percent * Double(sides) * repeats +
            // source when percent is 0, nothing when percent is 1 or more
            Double(source) * (1.0 - min(1.0, percent)) +
            // nothing when percent is 0 or less, target when percent is 1
            Double(target) * max(0.0, percent)

        let offset: CGFloat = getOffsetPercentage(absoluteNumber)

        let sideNumbers = [
            absoluteNumber - 2,
            absoluteNumber - 1,
            absoluteNumber,
            absoluteNumber + 1,
            absoluteNumber + 2
            ]
            .map { getSideNumber($0) }

        notifyCompletion()

        return
            ZStack {

                // MARK:- Dice

                VStack {
                    ForEach(sideNumbers, id: \.self) { number in
                        Text("\(number)").font(.largeTitle)
                            .frame(width: DiceConstants.slotFrameWidth, height: DiceConstants.numberFrameHeight)
                    }
                }
                .offset(x: 0, y: DiceConstants.numberFrameHeight * offset)
                .frame(width: DiceConstants.slotFrameWidth, height: DiceConstants.slotFrameHeight)
                .clipped()

                // MARK:- Wheel style

                if style == .wheel {
                    VStack(alignment: .center, spacing: 0) {
                        LinearGradient(
                            gradient: Gradient(colors: [
                                wheelMaskColor.opacity(wheelStyleStrength),
                                wheelMaskColor.opacity(0),
                                wheelMaskColor.opacity(wheelStyleStrength)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: DiceConstants.slotFrameHeight)
                    }
                }
        }
    }

    // MARK:- Private functions

    private func getSideNumber(_ number: Double) -> Int {
        // bring back to range
        var numberInRange = number.truncatingRemainder(dividingBy: Double(sides))

        // deal with negative numbers
        if numberInRange < 0 { numberInRange += Double(sides) }

        // truncate
        let truncatedNumber = Int(numberInRange)

        // replace 0 with max value
        if truncatedNumber == 0 { return sides }

        return truncatedNumber
    }

    private func getOffsetPercentage(_ number: Double) -> CGFloat {
        // bring back to range
        var numberInRange = number.truncatingRemainder(dividingBy: Double(sides))

        // deal with negative numbers
        if numberInRange < 0 { numberInRange += Double(sides) }

        // truncate
        let truncatedNumber = Int(numberInRange)

        return 1 - CGFloat(numberInRange - Double(truncatedNumber))
    }

    private func notifyCompletion() {
        if percent == 1.0 {
            if self.complete == false {
                // schedule the change to be done after the view has finished drawing,
                // thus avoiding changing the state while the view is being drawn
                DispatchQueue.main.async { self.complete = true }
            }
        }
    }
}


