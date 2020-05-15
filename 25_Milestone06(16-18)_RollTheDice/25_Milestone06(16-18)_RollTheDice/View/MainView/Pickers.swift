//
//  MainViewPickers.swift
//  25_Milestone06(16-18)_RollTheDice
//
//  Created by Jacob Zhang on 2020/5/12.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct DicePicker: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @Binding var diceNumber: Int
    let rollDisabled: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Dice").font(.caption)
                Spacer()
            }
            .padding(.leading, 2)
            
            Picker("", selection: $diceNumber) {
                ForEach(1...6, id: \.self) { i in
                    Text("\(i)").tag(i)
                    
                }
            }
            .modifier(CustomPickerStyle(rollDisabled: rollDisabled))
        }
    }
}

struct SidesPicker: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @Binding var diceSides: Int
    let rollDisabled: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Sides").font(.caption)
                Spacer()
            }
            .padding(.leading, 2)
            
            Picker("", selection: $diceSides) {
                Text("4").tag(4)
                Text("6").tag(6)
                Text("8").tag(8)
                Text("10").tag(10)
                Text("12").tag(12)
                Text("20").tag(20)
                Text("100").tag(100)
            }
            .modifier(CustomPickerStyle(rollDisabled: rollDisabled))
        }
    }
}

struct CustomPickerStyle: ViewModifier {
    let rollDisabled: Bool
    
    func body(content: Content) -> some View {
        content
            .pickerStyle(SegmentedPickerStyle())
            .disabled(rollDisabled)
            .background(Color.green.opacity(0.8))
            .cornerRadius(8)
            .animation(.linear(duration: 0.3))
    }
}

struct Pickers_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DicePicker(diceNumber: .constant(6), rollDisabled: false)
                .padding()
            
            DicePicker(diceNumber: .constant(6), rollDisabled: true)
                .padding()
            
            SidesPicker(diceSides: .constant(6), rollDisabled: false)
                .padding()
            
            SidesPicker(diceSides: .constant(6), rollDisabled: true)
                .padding()
        }
    }
}
