//
//  AnimatedGestures1.swift
//  08_Project06_Animations
//
//  Created by Jacob Zhang on 2020/5/1.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct AnimatedGestures1: View {
    @State private var dragAmount = CGSize.zero

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged { action in self.dragAmount = action.translation }
                    .onEnded { _ in
                        withAnimation(.spring()) {
                            self.dragAmount = .zero
                        }
                    }
            )
        }
    }
}

struct AnimatedGestures_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedGestures1()
    }
}
