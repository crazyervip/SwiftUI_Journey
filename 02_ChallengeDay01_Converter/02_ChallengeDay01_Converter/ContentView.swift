//
//  ContentView.swift
//  02_ChallengeDay01_Converter
//
//  Created by Jacob Zhang on 2020/4/28.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

enum UnitUsage {
    case source
    case destination
}

struct ContentView: View {
    // 输入值
    @State private var value = ""
    
    // 选择大类的单位类型 index
    @State private var unitTypeIndex = 0
    
    // 选择小类的初始单位 Index
    @State private var sourceNamedUnitIndex = Array(repeating: 0, count: UnitTypes.types.count)
    
    // 选择小类的目标单位 Index
    @State private var destinationNamedUnitIndex = Array(repeating: 0, count: UnitTypes.types.count)
    
    // 单位大类
    var unitTypes: [UnitType.Type] {
        return UnitTypes.types
    }
    
    // 单位小类
    var namedUnits: [NamedUnit] {
        return unitTypes[unitTypeIndex].units
    }
    
    // 选择小类的初始单位
    var sourceNamedUnit: NamedUnit {
        let selectedSourceIndex = sourceNamedUnitIndex[unitTypeIndex]
        return namedUnits[selectedSourceIndex]
    }
    
    // 选择小类的目标单位
    var destinationNamedUnit: NamedUnit {
        let selectedDestinationIndex = destinationNamedUnitIndex[unitTypeIndex]
        return namedUnits[selectedDestinationIndex]
    }
    
    // 换算结果
    var result: Double {
        let source = Measurement(value: Double(value) ?? 0, unit: sourceNamedUnit.unit)
        return source.converted(to: destinationNamedUnit.unit).value
    }
    
    var body: some View {
        NavigationView {
            Form {
                // 单位大类
                Section() {
                    Picker("", selection: $unitTypeIndex) {
                        ForEach(0 ..< unitTypes.count, id: \.self) {
                            Text("\(self.unitTypes[$0].name)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section() {
                    // 初始单位输入值
                    HStack {
                        TextField("在这里输入", text: $value)
                            .keyboardType(.decimalPad)
                        Spacer()
                        Text(sourceNamedUnit.name)
                    }
                    .padding(.horizontal)
                    
                    // 选择初始单位
                    Picker("", selection: $sourceNamedUnitIndex[unitTypeIndex]) {
                        ForEach(0 ..< namedUnits.count, id: \.self) { i in
                            Text(self.namedUnits[i].unit.symbol)
                        }
                    }
                        //MARK: Picker 中的元素是 Int 变量
                        .id(unitTypeIndex)
                        .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: HStack {
                    Spacer()
                    Image(systemName: "arrow.up.arrow.down.circle.fill")
                        .font(.title)
                        .padding(.bottom, 20)
                    Spacer()
                }) {
                    // 换算结果
                    HStack {
                        Text(format(number: result))
                        Spacer()
                        Text(destinationNamedUnit.name)
                    }
                    .padding(.horizontal)

                    // 选择目标单位
                    Picker("", selection: $destinationNamedUnitIndex[unitTypeIndex]) {
                        ForEach(0 ..< namedUnits.count, id: \.self) { i in
                            Text(self.namedUnits[i].unit.symbol)
                        }
                    }
                        //MARK: Picker 中的元素是 Int 变量
                        .id(unitTypeIndex)
                        .pickerStyle(SegmentedPickerStyle())
                }
            }
                // 滑动隐藏键盘
                .gesture(
                    DragGesture()
                        .onChanged {_ in
                            self.endEditing()
                    }
            )
                .navigationBarTitle("单位换算器")
                .animation(.spring())
        }
        // 使用双击隐藏键盘
        //        .modifier(DismissingKeyboard())
    }
    
    // 滑动隐藏键盘
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
    
    // 设置显示小数最多为5位
    func format(number: Double) -> String {
        // 比 %.5f specifier 方法好，因为可以自动去掉为 0 的小数
        let formatter = NumberFormatter()
        let nsnumber = NSNumber(value: number)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 5
        return String(formatter.string(from: nsnumber) ?? "")
    }
}

// 双击隐藏键盘
//struct DismissingKeyboard: ViewModifier {
//    func body(content: Content) -> some View {
//        // note: using a single tap breaks the Pickers
//        content.onTapGesture(count: 2) {
//            let keyWindow = UIApplication.shared.connectedScenes
//                .filter({$0.activationState == .foregroundActive})
//                .map({$0 as? UIWindowScene})
//                .compactMap({$0})
//                .first?.windows
//                .filter({$0.isKeyWindow}).first
//            keyWindow?.endEditing(true)
//        }
//    }
//}

// 滑动隐藏键盘
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .colorScheme(.dark)
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
