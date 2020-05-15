//
//  Intro04AbsolutPositioning.swift
//  24_Project18_LayoutAndGeometry
//
//  Created by Jacob Zhang on 2020/5/15.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct Intro04AbsolutePositioning: View {
    @Binding var topic: Topics

    var body: some View {
        TabView {
            Text("Hello, World!")
                .background(Color.blue)
                .position(x: 100, y: 100)
                .background(Color.red)
                .tabItem { Text("Position") }

            Text("Offsetted position")
                .border(Color.yellow)
                .offset(x: 50, y: 50) // applies to all above
                .border(Color.green)
                .offset(x: 100, y: 100) // applies to all above
                .background(Color.red)
                .offset(x: -75, y: -75) // applies to all above
                .background(Text("Original position"))
                .tabItem { Text("Offset") }
        }
        .onTapGesture(count: 2) { self.topic = .none }
    }
}

struct Intro04AbsolutPositioning_Previews: PreviewProvider {
    static var previews: some View {
        Intro04AbsolutePositioning(topic: .constant(.absolutePositioning))
    }
}
