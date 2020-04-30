//
//  PropertyViews.swift
//  04_Project03_ViewsAndModifiers
//
//  Created by Jacob Zhang on 2020/4/30.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct PropertyViews: View {
    let text1 = Text("SwiftUI 项目")
    let text2 = Text("由浅入深")

    // 或者
    //var text1: some View { Text("SwiftUI 项目") }
    //var text2: some View { Text("由浅入深") }

    var body: some View {
        VStack {
            text1
                .foregroundColor(.red)
            text2
                .foregroundColor(.blue)
        }
    }
}

struct PropertyViews_Previews: PreviewProvider {
    static var previews: some View {
        PropertyViews()
    }
}
