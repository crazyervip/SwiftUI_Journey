//
//  ContentView.swift
//  10_Project07_iExpense
//
//  Created by Jacob Zhang on 2020/5/1.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = Expenses()

    @State private var showingAddExpense = false

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }

                        Spacer()

                        Text("\(item.amount) 元")
                            .foregroundColor(self.color(forAmount: item.amount))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("记账")
            .navigationBarItems(
                leading: EditButton(), // challenge 1
                trailing: Button(action: {
                    self.showingAddExpense = true
                }) {
                    Image(systemName: "plus")
                        .padding(7)
                        .background(Color(.systemGray5))
                        .clipShape(Circle())
                }
            )
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: self.expenses)
        }
    }

    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }

    func color(forAmount amount: Int) -> Color {
        switch amount {
        case Int.min..<10:
            return .green
        case 10..<100:
            return .orange
        default:
            return .red
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
