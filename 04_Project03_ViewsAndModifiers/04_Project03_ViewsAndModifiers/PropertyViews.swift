//
//  PropertyViews.swift
//  04_Project03_ViewsAndModifiers
//
//  Created by Jacob Zhang on 2020/4/30.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct PropertyViews: View {
    let motto1 = Text("Draco dormiens")
    let motto2 = Text("nunquam titillandus")

    // or
    //var motto1: some View { Text("Draco dormiens") }
    //var motto2: some View { Text("nunquam titillandus") }

    var body: some View {
        VStack {
            motto1
                .foregroundColor(.red)
            motto2
                .foregroundColor(.blue)
        }
    }
}

struct PropertyViews_Previews: PreviewProvider {
    static var previews: some View {
        PropertyViews()
    }
}
