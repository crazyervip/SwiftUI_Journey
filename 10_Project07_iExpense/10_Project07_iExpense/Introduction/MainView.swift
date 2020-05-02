//
//  MainView.swift
//  10_Project07_iExpense
//
//  Created by Jacob Zhang on 2020/5/2.
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
        NamedView("Why @State only works with structs", view: StateAndStruct()),
        NamedView("Sharing SwiftUI state with @ObservedObject", view: ObservedObjects()),
        NamedView("Showing and hiding views", view: ShowHideViews()),
        NamedView("Deleting items using onDelete()", view: DeleteItems()),
        NamedView("Storing user settings with UserDefaults", view: UserDefaultsData()),
        NamedView("Archiving Swift objects with Codable", view: CodableData())
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
