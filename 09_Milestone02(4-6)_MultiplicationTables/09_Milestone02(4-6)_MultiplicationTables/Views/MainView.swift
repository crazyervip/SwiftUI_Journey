//
//  MainView.swift
//  09_Milestone02(4-6)_MultiplicationTables
//
//  Created by Jacob Zhang on 2020/5/1.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

class SettingsToggle: ObservableObject {
    @Published var isSettingsDisplayed = true
}

struct MainView: View {
    @ObservedObject var settings = Settings()
    @ObservedObject var settingsToggle = SettingsToggle()

    var body: some View {
        NavigationView {
            Group {
                if settingsToggle.isSettingsDisplayed {
                    SettingsView(settings: settings, settingsToggle: settingsToggle)
                }
                else {
                    GameView(settings: settings, settingsToggle: settingsToggle)
                }
            }
            .navigationBarTitle("乘法表")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
//            .colorScheme(.dark)
    }
}

