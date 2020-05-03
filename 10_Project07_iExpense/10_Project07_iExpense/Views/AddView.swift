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
    @State private var type = "Personal"
    @State private var amount = ""

    @State private var showingAlert = false

    static let types = ["Business", "Personal"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \String.self) {
                        Text($0)
                    }
                }

                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing:
                Button("Save") {
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
            Alert(title: Text("Incorrect amount"), message: Text("Amount must be an integer"), dismissButton: .default(Text("OK")))
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
