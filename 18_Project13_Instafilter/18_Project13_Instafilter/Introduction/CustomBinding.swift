//
//  CustomBinding.swift
//  18_Project13_Instafilter
//
//  Created by Jacob Zhang on 2020/5/5.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

// workaround for using didSet on a @State property
struct CustomBinding: View {
    // State's wrappedValue is nonmutating: didSet would never be called
    @State private var blurAmount: CGFloat = 0

    var body: some View {
        // must be declared in the body otherwise it wouldn't be
        // able to modify another property (blurAmount)
        // initializer takes a get and set method
        let blur = Binding<CGFloat>(
            get: { self.blurAmount },
            set: {
                self.blurAmount = $0
                print("New value is \(self.blurAmount)")
            }
        )

        return VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)

            // blur is already a Binding, no need for the $ sign
            Slider(value: blur, in: 0...20)
        }
    }
}

struct CustomBinding_Previews: PreviewProvider {
    static var previews: some View {
        CustomBinding()
    }
}
