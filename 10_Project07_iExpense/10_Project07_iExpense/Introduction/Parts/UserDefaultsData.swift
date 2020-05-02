//
//  UserDefaultsData.swift
//  10_Project07_iExpense
//
//  Created by Jacob Zhang on 2020/5/2.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct UserDefaultsData: View {
    static private let tapKey = "Tap"

    @State private var tapCount = UserDefaults.standard.integer(forKey: Self.tapKey)

    var body: some View {
        Button("Tap Count: \(tapCount)") {
            self.tapCount += 1
            UserDefaults.standard.set(self.tapCount, forKey: Self.tapKey)
        }
    }
}

struct UserDefaults_Previews: PreviewProvider {
    static var previews: some View {
        UserDefaultsData()
    }
}
