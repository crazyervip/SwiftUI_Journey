//
//  MainView.swift
//  20_Project15_Accessibility
//
//  Created by Jacob Zhang on 2020/5/8.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct NamedView {
    var name: String
    var view: AnyView

    init<V>(_ name: String, view: V) where V: View {
        self.name = name
        self.view = AnyView(view)
    }
}

struct MainView: View {
    private let topics: [NamedView] = [
        NamedView("Identifying views with useful labels", view: IdentifyViews()),
        NamedView("Hiding and grouping accessibility data", view: HidingAndGrouping()),
        NamedView("Reading the value of controls", view: ValueOfControls())
    ]

    var body: some View {
        NavigationView {
            List(0..<topics.count) { i in
                NavigationLink(destination: self.topics[i].view) {
                    Text(self.topics[i].name)
                }
            }
            .navigationBarTitle("Topics")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}