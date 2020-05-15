//
//  MainViewRollButton.swift
//  25_Milestone06(16-18)_RollTheDice
//
//  Created by Jacob Zhang on 2020/5/12.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct RollButton: View {
    var rollDisabled: Bool
    var rollAction: () -> Void
    
    var body: some View {
        ZStack {
            Button(
                action: rollAction,
                label: {
                    HStack{
                        Spacer()
                        Text("⚁")
                            .font(.largeTitle)
                            .rotationEffect(.radians(.pi / 8))
                        Text("ROLL")
                            .font(.title)
                            .padding(.horizontal)
                        Text("⚄")
                            .font(.largeTitle)
                            .rotationEffect(.radians(.pi / 8))
                        Spacer()
                    }
            }
            )
                .foregroundColor(rollDisabled ? .secondary : .primary)
//                .accentColor(.black)
                .padding(.vertical, 8)
                .background(Color.green.opacity(0.8))
                .cornerRadius(8)
                .disabled(rollDisabled)
                .brightness(rollDisabled ? -0.08 : 0)
                .scaleEffect(rollDisabled ? 0.95 : 1)
                .animation(.linear(duration: 0.3))
        }
    }
}

struct RollButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RollButton(rollDisabled: false, rollAction: {})
                .padding()
            
            RollButton(rollDisabled: true, rollAction: {})
                .padding()
        }
    }
}
