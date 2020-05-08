//
//  AddressView.swift
//  13_Project10_CupcakesCorner
//
//  Created by Jacob Zhang on 2020/5/3.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    // challenge 3
    @ObservedObject var oo: ObservableOrder

    var body: some View {
        Form {
            Section {
                TextField("姓名", text: $oo.order.name)
                TextField("街道地址", text: $oo.order.streetAddress)
                TextField("城市", text: $oo.order.city)
                TextField("邮编", text: $oo.order.zip)

            }

            Section {
                NavigationLink(destination: CheckoutView(oo: oo)){
                    Text("确定")
                        .foregroundColor(oo.order.hasValidAddress == false ? nil : Color(.systemBlue))
                }
                .disabled(oo.order.hasValidAddress == false)
                
            }
        }
        .navigationBarTitle("送餐详情", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        // challenge 3
        AddressView(oo: ObservableOrder(order: Order()))
    }
}
