//
//  Intro01-Layout.swift
//  24_Project18_LayoutAndGeometry
//
//  Created by Jacob Zhang on 2020/5/15.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct Intro01Layout: View {
    @Binding var topic: Topics

    var body: some View {
        TabView {
            VStack {
                Spacer()

                Text("View->Background->Text")
                    .background(Color.red)

                Spacer()

                Text("View->Background->Padding->Text")
                    .padding(20)
                    .background(Color.red)

                Spacer()

                Text("View->Padding->Background->Text")
                    .background(Color.red)
                    .padding()
                    //.border(Color.gray)

                Spacer()
            }
            .tabItem {
                Image(systemName: "1.circle")
                Text("Fixed size")
            }


            Color.red
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("Neutral size")
                }
        }
        .onTapGesture(count: 2) { self.topic = .none }
    }
}

struct Intro01Layout_Previews: PreviewProvider {
    static var previews: some View {
        Intro01Layout(topic: .constant(.layout))
    }
}
