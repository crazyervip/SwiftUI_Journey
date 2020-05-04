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
                TextField("Name", text: $oo.order.name)
                TextField("Street Address", text: $oo.order.streetAddress)
                TextField("City", text: $oo.order.city)
                TextField("Zip", text: $oo.order.zip)

            }

            Section {
                NavigationLink(destination: CheckoutView(oo: oo)){
                    Text("Checkout")
                }
                .disabled(oo.order.hasValidAddress == false)
            }
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        // challenge 3
        AddressView(oo: ObservableOrder(order: Order()))
    }
}
