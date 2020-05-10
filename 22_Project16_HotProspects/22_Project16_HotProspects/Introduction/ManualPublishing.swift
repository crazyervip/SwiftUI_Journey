//
//  ManualPublishing.swift
//  22_Project16_HotProspects
//
//  Created by Jacob Zhang on 2020/5/10.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

class DelayedUpdater: ObservableObject {
    /* @Published */ var value = 0 {
        willSet {
            // sending this publishes without the @Published keyword,
            // all the while giving control over value changes (for
            // instance some validation of value could be done here)
            objectWillChange.send()
        }
    }

    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

struct ManualPublishing: View {
    @ObservedObject var updater = DelayedUpdater()

    var body: some View {
        Text("Value is: \(updater.value)")
    }
}

struct ManualPublishing_Previews: PreviewProvider {
    static var previews: some View {
        ManualPublishing()
    }
}
