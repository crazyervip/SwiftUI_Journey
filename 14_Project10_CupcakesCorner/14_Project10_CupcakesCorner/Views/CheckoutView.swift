//
//  CheckoutView.swift
//  13_Project10_CupcakesCorner
//
//  Created by Jacob Zhang on 2020/5/3.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

enum AlertType {
    case confirmation
    case error
}

struct CheckoutView: View {
    // challenge 3
    @ObservedObject var oo: ObservableOrder

    @State private var confirmationMessage = ""
    
    @State private var extra = "无"

    // challenge 2
    @State private var showingAlert = false
    @State private var errorMessage = ""
    @State var alertType = AlertType.confirmation

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)

                    Text("订单总额为 \(self.oo.order.cost, specifier: "%.2f") 元")
                        .font(.title)

                    Button("下单") {
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("确定订单", displayMode: .inline)
        // challenge 2
        .alert(isPresented: $showingAlert) { () -> Alert in
            switch alertType {
            case .confirmation:
                return Alert(title: Text("感谢你！"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
            case .error:
                return Alert(title: Text("出错了!"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(oo.order) else {
            // challenge 2 encode
            self.show(error: "无法上传订单")
            return
        }

        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                // challenge 2
                self.show(error: "无数据回应: \(error?.localizedDescription ?? "未知错误")")
                return
            }

            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                // challenge 2
                if decodedOrder.addSprinkles && !decodedOrder.extraFrosting {
                    self.extra = "巧克力屑"
                } else if !decodedOrder.addSprinkles && decodedOrder.extraFrosting {
                    self.extra = "奶油"
                } else if decodedOrder.addSprinkles && decodedOrder.extraFrosting {
                    self.extra = "奶油，巧克力屑"
                }
                
                self.show(confirmation: "你的 \(decodedOrder.quantity) 个  \(Order.types[decodedOrder.type])蛋糕\n(辅料：\(self.extra))\n将马上送达")
            }
            else {
                // challenge 2
                self.show(error: "Invalid response from server")
            }
        }.resume()
    }

    // challenge 2
    func show(error: String) {
        self.errorMessage = error
        self.alertType = .error
        self.showingAlert = true
    }

    // challenge 2
    func show(confirmation: String) {
        self.confirmationMessage = confirmation
        self.alertType = .confirmation
        self.showingAlert = true
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        // challenge 3
        CheckoutView(oo: ObservableOrder(order: Order()))
    }
}
