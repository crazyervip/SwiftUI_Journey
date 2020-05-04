//
//  AddView.swift
//  10_Project07_iExpense
//
//  Created by Jacob Zhang on 2020/5/2.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var expenses: Expenses

    @State private var name = ""
    @State private var type = "私人"
    @State private var amount = ""

    @State private var showingAlert = false

    static let types = ["公/商务", "私人"]

    var body: some View {
        NavigationView {
            Form {
                TextField("名称", text: $name)

                Picker("种类", selection: $type) {
                    ForEach(Self.types, id: \String.self) {
                        Text($0)
                    }
                }

                TextField("金额", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("添加支出")
            .navigationBarItems(trailing:
                Button("保存") {
                    if let actualAmount = Int(self.amount) {
                        let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                        self.expenses.items.append(item)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    else {
                        self.showingAlert = true
                    }
                }
            )
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("金额不正确"), message: Text("必须为整数"), dismissButton: .default(Text("OK")))
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
