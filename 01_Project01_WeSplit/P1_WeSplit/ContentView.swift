//
//  ContentView.swift
//  P1_WeSplit
//
//  Created by Jacob Zhang on 2020/4/27.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI
import Introspect

struct ContentView: View {
    // `@` 是一种属性包装器 (Property Wrapper)，使用 `@State` 的 `var` 可时刻监听 `body` 中对应值的变化并随之变化（mutating）
    // 使用 `private var` 可节省内存
    // 使用在 `TextField` 中的 `var` 一般是 `String` 类型 , `Int` 类型需在 TF 里改 `text ：`为 `value: ` ，并添加 `formatter: NumberFormatter()`
    @State private var checkAmount: String = ""
    
    @State private var tipPercentage: Int = 0
    //MARK: 如果为 Int 则不会随输入自动更新，需按下回车键
    @State private var numberOfPeople: Int = 2
    
    @State private var editingFinished: Bool = false
    
    let tipPercentages = [0, 10, 15, 20, 25]
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        // `??` 为空合运算符：使 `Double(checkAmount)` 为可选性，如果 `Double(checkAmount)` 为空，则使用默认使用 `0`
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        
        return grandTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    // spacing 默认值为 8
                    HStack(spacing: 8) {
                        Text("总金额")
                            .frame(minWidth: 150, alignment: .leading)
                        Spacer()
                        // `$` 提供同一个 `Struct` 内部的双向绑定（two-way binding）, 此处 `checkAmount` 可随用户输入更新
                        TextField("输入金额", text: $checkAmount)
                            //  完成按钮使用方法
                            .introspectTextField { textField in
                                textField.addDoneCancelToolbar()
                        }
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("元")
                    }
                    
                    HStack(spacing: 8) {
                        Text("人数")
                            .frame(minWidth: 150, alignment: .leading)
                        Spacer()
                        TextField("包括自己", value: $numberOfPeople, formatter: NumberFormatter())
                        .keyboardType(.numbersAndPunctuation)
                        .disableAutocorrection(true)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        Stepper("", value: $numberOfPeople, in: 1...1000).labelsHidden()
                    }
                }
                
                Section(header: Text("要付多少比例的小费?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("总金额 + 小费")) {
                    Text("\(grandTotal, specifier: "%.2f") 元")
                }
                Section(header: Text("人均")) {
                    // 显示 `Double` 小数点方法
                    Text("\(totalPerPerson, specifier: "%.2f") 元")
                }
            }
            // 滑动隐藏键盘
            .gesture(
                DragGesture()
                    .onChanged {_ in
                        self.endEditing()
                }
            )
                .navigationBarTitle("AA 收款")
        }
    }
    // 滑动隐藏键盘
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .colorScheme(.dark)
    }
}

// 滑动隐藏键盘
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// 添加完成按钮
extension UITextField {
    func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
        //    let onCancel = onCancel ?? (target: self, action: #selector(tapCancel))
        let onDone = onDone ?? (target: self, action: #selector(tapDone))
        
        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            //        UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "完成", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()
        
        self.inputAccessoryView = toolbar
    }
    @objc func tapDone() {
        print("tapped Done")
        self.resignFirstResponder()
    }
    @objc func tapCancel() {
        print("tapped cancel")
        self.resignFirstResponder()
    }
}

