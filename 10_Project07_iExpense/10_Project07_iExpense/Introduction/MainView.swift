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
        NamedView("Struct Class ObservableObject", view: StructClassObservableObject()),
        NamedView("展示和隐藏 Views", view: ShowHideViews()),
        NamedView("使用 onDelete() 删除元素", view: DeleteItems()),
        NamedView("使用 UserDefaults 保存用户设置", view: UserDefaultsData()),
        NamedView("使用 Codable 来归档位 Swift 对象", view: CodableData())
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
