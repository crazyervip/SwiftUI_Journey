//
//  TabbedRootView.swift
//  22_Project16_HotProspects
//
//  Created by Jacob Zhang on 2020/5/10.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct TabbedRootView: View {
    var prospects = Prospects()

    var body: some View {
        TabView {
            ProspectsView(filter: .none)
                .tabItem {
                    Image(systemName: "person.3")
//                    Text("所有人")
            }

            ProspectsView(filter: .contacted)
                .tabItem {
                    Image(systemName: "checkmark.circle")
//                    Text("已联系")
            }

            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Image(systemName: "questionmark.diamond")
//                    Text("未联系")
            }

            MeView()
                .tabItem {
                    Image(systemName: "person.crop.square")
//                    Text("我")
            }
        }
        .environmentObject(prospects)
    }
}

struct TabbedRootView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedRootView()
    }
}
