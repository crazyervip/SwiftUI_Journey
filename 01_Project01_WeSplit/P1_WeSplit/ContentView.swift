//
//  ContentView.swift
//  P1_WeSplit
//
//  Created by Jacob Zhang on 2020/4/27.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // `@` 是一种属性包装器 (Property Wrapper)，使用 `@State` 的 `var` 可时刻监听 `body` 中对应值的变化并随之变化（mutating）
    // 使用 `private var` 可节省内存
    // 使用在 `TextField` 中的 `var` 一般是 `String` 类型 , `Int` 类型需在TF里添加 `formatter: NumberFormatter()`
    @State private var checkAmount: String = ""
    
    @State private var tipPercentage = 2
    
    @State private var numberOfPeople = 1
    
    @State private var editingFinished = false

    let tipPercentages = [10, 15, 20, 25, 0]
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        // `??` 为空合运算符：使 `Double(checkAmount)` 为可选性，如果 `Double(checkAmount)` 为空，则使用默认使用 `0`
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        
        return grandTotal
    }
    
    var totalPerPerson: Double {
        let amountPerPerson = grandTotal / Double(numberOfPeople)
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    // `$` 提供同一个 `Struct` 内部的双向绑定（two-way binding）, 此处 `checkAmount` 可随用户输入更新
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    // keyboardType 大全
                    //                    Text(String(numberOfPeople))
                    HStack(spacing: 0) {
                        Text("Number of people")
                            .padding(Edge.Set.trailing, 10)
                        TextField("", value: $numberOfPeople, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.center)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(minWidth: 15, maxWidth: 50)
                            .padding(Edge.Set.trailing, 10)
                        Spacer()
                        Stepper("", value: $numberOfPeople, in: 1...100)
                            .labelsHidden()
                    }
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Total amount")) {
                    Text("$\(grandTotal, specifier: "%.2f")")
                }
                
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .gesture(
                DragGesture()
                    .onChanged {_ in
                        self.endEditing()
                }
            )
            .navigationBarTitle("WeSplit")
        }
    }
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//MARK: 模糊背景
struct BlurBg: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
