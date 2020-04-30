//
//  EnvironmentModifiers.swift
//  04_Project03_ViewsAndModifiers
//
//  Created by Jacob Zhang on 2020/4/30.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct EnvironmentModifiers: View {
    var body: some View {
        VStack {
            Spacer()
            EnvironmentModifier()
            Spacer()
            RegularModifier()
            Spacer()
        }
    }
}

struct EnvironmentModifier: View {
    var body: some View {
        VStack {
            Text("SwiftUI 项目")
                .font(.largeTitle) //  重写字体，显示为 largeTitle
            Text("由浅入深")
        }
        .font(.title) // 全部显示为 title
    }
}

struct RegularModifier: View {
    var body: some View {
        VStack {
            VStack {
                Text("SwiftUI 项目")
                    .blur(radius: 7) // 重写模糊，显示为 .blur(radius: 10) ,最低为 3，使用 -3 无法取消模糊
                Text("由浅入深")
            }
            .blur(radius: 3) // 全部显示为 .blur(radius: 3)
            .font(.title)
        }
    }
}

struct EnvironmentModifiers_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentModifiers()
    }
}

