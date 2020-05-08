////
////  ContentView.swift
////  06_Project04_BetterRest
////
////  Created by Jacob Zhang on 2020/5/1.
////  Copyright © 2020 Jacob Zhang. All rights reserved.
////
//
//import SwiftUI
//
//struct ContentView: View {
//    @State private var wakeUp = defaultWakeTime
//    @State private var sleepAmount = 8.0
//    @State private var coffeeAmount = 0
//
//    var body: some View {
//        NavigationView {
//            Form {
//                //MARK: challenge 1
//                Section(header: Text("你想什么时候起床？").font(.headline)) {
//                    DatePicker("", selection: $wakeUp, displayedComponents: .hourAndMinute)
//                        .labelsHidden()
//                        .datePickerStyle(WheelDatePickerStyle())
//                }
//
//                //MARK: challenge 1
//                Section(header: Text("你想睡多久？").font(.headline)) {
//                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
//                        //MARK: 自动控制小数点
//                        Text("\(sleepAmount, specifier: "%g") 小时")
//                    }
//                }
//
//                //MARK: challenge 1
//                Section(header: Text("今天喝了几杯咖啡？").font(.headline)) {
//                    //MARK: challenge 2
////                    Picker("今天喝了几杯咖啡？", selection: $coffeeAmount) {
////                        ForEach(0...20, id: \.self) { i in
////                            //MARK: 如果为英文注意单复数问题
//////                            Text("\(i) \(i == 0 || i == 1 ? "cup" : "cups")")
////                            Text("\(i) 杯")
////                        }
////                    }
////                    .labelsHidden()
////                    .pickerStyle(WheelPickerStyle())
//
//                    Stepper(value: $coffeeAmount, in: 0...20) {
//                        Text("\(coffeeAmount) 杯")
//                        //MARK: 如果为英文注意单复数问题
////                        if coffeeAmount == 0 || coffeeAmount == 1 {
////                            Text("\(coffeeAmount) cup")
////                        }
////                        else {
////                            Text("\(coffeeAmount) cups")
////                        }
//                    }
//                }
//
//                // challenge 3
//                Section(header: Text("推荐就寝时间").font(.headline)) {
//                    Text("\(calculatedBedTime)")
//                        .font(.title)
//                }
//            }
//            .navigationBarTitle("好睡眠")
//        }
//    }
//
//    static var defaultWakeTime: Date {
//        var components = DateComponents()
//        components.hour = 7
//        components.minute = 0
//        return Calendar.current.date(from: components) ?? Date()
//    }
//
//    //MARK: challenge 3
//    var calculatedBedTime: String {
//        let model = SleepCalculator()
//
//        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
//        let hour = (components.hour ?? 0) * 60 * 60
//        let minute = (components.minute ?? 0) * 60
//
//        var message: String
//        do {
//            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
//
//            let sleepTime = wakeUp - prediction.actualSleep
//
//            let formatter = DateFormatter()
//            formatter.timeStyle = .short
//
//            message = formatter.string(from: sleepTime)
//        }
//        catch {
//            message = "就寝时间计算错误"
//        }
//
//        return message
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
