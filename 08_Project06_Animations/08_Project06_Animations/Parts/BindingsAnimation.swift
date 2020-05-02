//
//  BindingsAnimation.swift
//  08_Project06_Animations
//
//  Created by Jacob Zhang on 2020/5/1.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct BindingsAnimation: View {
    @State private var animationAmount: CGFloat = 1

    var body: some View {
        print(animationAmount)

        return VStack {
            Spacer()
            Button("Tap Me") {
                self.animationAmount += 1
            }
            .padding(40)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
            Spacer()
            Stepper("Scale amount",
                    value: $animationAmount.animation(
                        Animation.easeInOut(duration: 1)
                            .repeatCount(3, autoreverses: true)
                    ),
                    in: 1...10)
                .padding()
            
        }
    }
}

struct BindingsAnimation_Previews: PreviewProvider {
    static var previews: some View {
        BindingsAnimation()
    }
}
