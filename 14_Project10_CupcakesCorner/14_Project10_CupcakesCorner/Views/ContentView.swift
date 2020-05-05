//
//  ContentView.swift
//  13_Project10_CupcakesCorner
//
//  Created by Jacob Zhang on 2020/5/3.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var oo = ObservableOrder(order: Order())

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("选择蛋糕类型", selection: $oo.order.type) {
                        ForEach(0..<Order.types.count, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }

                    Stepper(value: $oo.order.quantity, in: 3...20) {
                        Text("数量: \(oo.order.quantity)")
                    }
                }

                Section {
                    Toggle(isOn: $oo.order.specialRequestEnabled.animation()) {
                        Text("加辅料?")
                    }

                    if oo.order.specialRequestEnabled {
                        Toggle(isOn: $oo.order.extraFrosting) {
                            Text("奶油")
                        }

                        Toggle(isOn: $oo.order.addSprinkles) {
                            Text("巧克力屑")
                        }
                    }
                }

                Section {
                    NavigationLink(destination: AddressView(oo: oo)) {
                        Text("送餐详情")
                    }
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
