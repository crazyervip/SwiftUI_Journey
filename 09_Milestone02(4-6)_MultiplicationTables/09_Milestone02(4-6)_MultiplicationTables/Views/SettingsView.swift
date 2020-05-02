//
//  SettingsView.swift
//  09_Milestone02(4-6)_MultiplicationTables
//
//  Created by Jacob Zhang on 2020/5/1.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var settings: Settings
    @ObservedObject var settingsToggle: SettingsToggle
    
    var body: some View {
        VStack(spacing: 0) {
            Form {
                Section(header:
                    Text("训练哪位数？")
                        .font(.title)
                        .foregroundColor(.orange)) {
                            Stepper(value: $settings.tablesUpTo, in: 1...12) {
                                Text("\(settings.tablesUpTo)")
                            }
                }
                Section(header:
                    Text("选择训练数量")
                        .font(.title)
                        .foregroundColor(.purple)) {
                            Picker("", selection: $settings.numberOfQuestionsIndex) {
                                ForEach(0..<settings.numbersOfQuestions.count, id: \Int.self) { i in
                                    Text(self.numberOfQuestionsText(for: i))
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .font(.largeTitle)
                }
            }
            HStack(spacing: 0) {
                Spacer()
                Button("开始") {
                    self.settingsToggle.isSettingsDisplayed.toggle()
                }
                .font(.system(size: 40))
                Spacer()
                
            }
            .padding()
            .padding(.bottom)
            .background(Color("Background"))
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarItems(
            leading: Spacer(),
            trailing: Spacer()
        )
    }
    
    func numberOfQuestionsText(for i: Int) -> String {
        let noq = self.settings.numbersOfQuestions[i]
        return noq == .all ? "全部 (\(settings.maxNumberOfQuestions))" : noq.rawValue
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(settings: Settings(), settingsToggle: SettingsToggle())
            .colorScheme(.dark)
    }
}
