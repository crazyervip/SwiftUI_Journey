//
//  AddActivity.swift
//  13_Milestone03(7-9)_HabitsTracker
//
//  Created by Jacob Zhang on 2020/5/3.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct AddActivity: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var habits: Habits

    @State private var title = ""
    @State private var description = ""
    
    @State private var showingAlert = false

    var body: some View {
        NavigationView {
            Form {
                TextField("标题（必填）", text: $title)
                TextField("描述（可选）", text: $description)
            }
            .navigationBarTitle("添加习惯")
            .navigationBarItems(trailing: Button("保存") {
                if self.title == "" {
                    self.showingAlert = true
                } else  {
                
                let activity = Activity(title: self.title, description: self.description)
                self.habits.add(activity: activity)
                self.presentationMode.wrappedValue.dismiss()
                }
            })
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("无法保存"), message: Text("标题为空"), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct AddActivity_Previews: PreviewProvider {
    static var previews: some View {
        AddActivity(habits: Habits())
    }
}
