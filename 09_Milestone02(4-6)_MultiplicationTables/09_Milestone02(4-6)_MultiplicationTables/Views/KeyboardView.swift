//
//  KeyboardView.swift
//  09_Milestone02(4-6)_MultiplicationTables
//
//  Created by Jacob Zhang on 2020/5/1.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

enum KeyboardActions: Int {
    case k0 = 0, k1, k2, k3, k4, k5, k6, k7, k8, k9, delete, submit, none
}

struct KeyboardTextStyle: ViewModifier {
    var width: CGFloat
    var height: CGFloat
    var bgColor: Color = Color.blue.opacity(0.8)

    func body(content: Content) -> some View {
        content
            .font(.title)
            .frame(maxWidth: width, maxHeight: height)
            .foregroundColor(Color.white)
            .background(bgColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct KeyboardView: View {
    var actionPerformed: ((KeyboardActions) -> ())?

    var body: some View {
        GeometryReader { g in
            VStack(alignment: .center, spacing: 10) {
                Spacer()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight:0, maxHeight: .infinity, alignment: Alignment.top)

                ForEach(0...2, id: \.self) { i in
                    HStack {
                        ForEach(1...3, id: \.self) { j in
                            Button(action: {
                                self.actionPerformed?(KeyboardActions.init(rawValue: j + i * 3) ?? .none)
                            }) {
                                Text("\(j + i * 3)")
                                    .modifier(KeyboardTextStyle(width: self.getWidth(g), height: self.getHeight()))
                            }
                        }
                    }
                }

                HStack {
                    Button(action: { self.actionPerformed?(.delete) }) {
                        Image(systemName: "delete.left")
                            .modifier(KeyboardTextStyle(width: self.getWidth(g), height: self.getHeight(), bgColor: Color.red.opacity(0.8)))
                    }
                    Button(action: { self.actionPerformed?(.k0) }) {
                        Text("0")
                            .modifier(KeyboardTextStyle(width: self.getWidth(g), height: self.getHeight()))
                    }
                    Button(action: { self.actionPerformed?(.submit) }) {
                        Text("Submit")
                            .modifier(KeyboardTextStyle(width: self.getWidth(g), height: self.getHeight(), bgColor: Color.green.opacity(0.8)))
                    }
                }
            }
        }
    }

    func getWidth(_ geometry: GeometryProxy) -> CGFloat {
        return geometry.size.width / 3 - 10
    }

    func getHeight() -> CGFloat {
        return 50
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView()
    }
}
