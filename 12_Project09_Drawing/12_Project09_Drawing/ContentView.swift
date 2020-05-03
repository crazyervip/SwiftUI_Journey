//
//  ContentView.swift
//  12_Project09_Drawing
//
//  Created by Jacob Zhang on 2020/5/3.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    private let topics: [NamedView] = [
        NamedView("Introduction", view: MainView()),
        NamedView("Challenges 1 & 2 - Arrow", view: ArrowChallenge()),
        NamedView("Challenge 3 - ColorCyclingRectangle", view: Challenge3()),
    ]

    var body: some View {
        NavigationView {
            List(0..<topics.count) { i in
                NavigationLink(destination: self.topics[i].view) {
                    Text(self.topics[i].name)
                }
            }
            .navigationBarTitle("Drawing")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
