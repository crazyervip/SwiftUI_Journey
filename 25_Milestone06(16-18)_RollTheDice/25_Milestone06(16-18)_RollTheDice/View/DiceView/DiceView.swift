//
//  DiceView.swift
//  25_Milestone06(16-18)_RollTheDice
//
//  Created by Jacob Zhang on 2020/5/12.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct DiceView: View {
    // MARK: - Parameters

    /// Dice sides
    let sides: Int

    /// Source side to animate from
    let source: Int

    /// Target side to animate to
    let target: Int

    /// Animation percentage
    let percent: Double

    /// True when animation is complete
    @Binding var complete: Bool

    var body: some View {
        Text("100")
            .modifier(
                DiceAnimatableModifier(sides: sides,
                                      source: source,
                                      target: target,
                                      percent: percent,
                                      complete: $complete)
            )
    }
}

struct Dice_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            DiceView(sides: 6, source: 1, target: 3,
                     percent: 0, complete: .constant(true))

            DiceView(sides: 6, source: 1, target: 3,
                     percent: 1, complete: .constant(true))

            DiceView(sides: 100, source: 1, target: 1,
                     percent: 1, complete: .constant(true))
        }
    }
}
