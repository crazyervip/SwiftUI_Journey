//
//  Expenses.swift
//  10_Project07_iExpense
//
//  Created by Jacob Zhang on 2020/5/2.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import Foundation

class Expenses: ObservableObject {
    private static let itemsKey = "Items"
    
    @Published var items: [ExpenseItem] {
        didSet {
            let encoder = JSONEncoder()

            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: Self.itemsKey)
            }
        }
    }

    init() {
        if let items = UserDefaults.standard.data(forKey: Self.itemsKey) {
            let decoder = JSONDecoder()

            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }

        self.items = []
    }
}

