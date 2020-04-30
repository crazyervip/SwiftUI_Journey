//
//  ConditionalModifiers.swift
//  04_Project03_ViewsAndModifiers
//
//  Created by Jacob Zhang on 2020/4/30.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct ConditionalModifiers: View {
    @State private var useRedText = false

    var body: some View {
        Button("Hello World") {
            // 像开关一样转换 Bool 值
            self.useRedText.toggle()
        }
        .foregroundColor(useRedText ? .red : .blue)
    }
}

// MARK: 会报错，因为两个 Views 返回的类型不同 because 2 views returned are of different types
//struct ConditionalModifiers: View {
//    @State private var useRedText = false
//
//    var body: some View {
//        if self.useRedText {
//            return Text("Hello World")
//                .foregroundColor(Color.clear)
//        } else {
//            return Text("Hello World")
//                .background(Color.red)
//        }
//    }
//}

struct ConditionalModifiers_Previews: PreviewProvider {
    static var previews: some View {
        ConditionalModifiers()
    }
}
