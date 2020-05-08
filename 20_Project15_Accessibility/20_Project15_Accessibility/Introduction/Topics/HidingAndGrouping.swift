//
//  HidingAndGrouping.swift
//  20_Project15_Accessibility
//
//  Created by Jacob Zhang on 2020/5/8.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct HidingAndGrouping: View {
    var body: some View {
        VStack {
            Image(decorative: "ales-krivec-15949") // don't read image name
                .resizable()
                .scaledToFit()
                 // invisible from accessibility (useful for hidden elements)
                .accessibility(hidden: true)

            Spacer()

            VStack {
                Text("This text will be read")
                Text("in two parts")
            }
            .accessibilityElement(children: .combine)

            Spacer()

            VStack {
                Text("This text won't be read")
                Text("(the accessibility")
                Text("label will be)")
            }
            .accessibilityElement(children: .ignore)
            .accessibility(label: Text("You are hearing the accessibility label"))

            Spacer()
        }
        .navigationBarTitle("Hiding and grouping accessibility data", displayMode: .inline)
    }
}

struct HidingAndGrouping_Previews: PreviewProvider {
    static var previews: some View {
        HidingAndGrouping()
    }
}
