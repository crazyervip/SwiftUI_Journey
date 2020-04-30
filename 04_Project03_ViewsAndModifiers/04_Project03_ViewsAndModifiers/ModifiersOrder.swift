//
//  ModifiersOrder.swift
//  04_Project03_ViewsAndModifiers
//
//  Created by Jacob Zhang on 2020/4/30.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct ModifiersOrder: View {
    var body: some View {
        VStack {
            Spacer()

            Button("Hello World") {
                print(type(of: self.body))
            }
            .frame(width: 200, height: 200)
            .background(Color.red)

            Spacer()

            Text("Hello World")
            .padding()
            .background(Color.red)
            .padding()
            .background(Color.blue)
            .padding()
            .background(Color.green)
            .padding()
            .background(Color.yellow)

            Spacer()
        }
    }
}

struct ModifiersOrder_Previews: PreviewProvider {
    static var previews: some View {
        ModifiersOrder()
    }
}
