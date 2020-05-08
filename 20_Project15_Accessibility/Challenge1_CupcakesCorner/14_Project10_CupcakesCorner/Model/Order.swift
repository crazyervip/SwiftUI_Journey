//
//  Order.swift
//  13_Project10_CupcakesCorner
//
//  Created by Jacob Zhang on 2020/5/3.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import Foundation

enum OrderCodingKeys: CodingKey {
    case type
    case quantity
    case extraForsting
    case addSprinkles
    case name
    case streetAddress
    case city
    case zip
}

// challenge 3
class ObservableOrder: ObservableObject {
    @Published var order: Order

    init(order: Order) {
        self.order = order
    }
}

// challenge 3
struct Order: Codable {
    static let types = ["香草", "草莓", "巧克力", "蓝莓"]

    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false

    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""

    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }

        // challenge 1
        if name.isAllSpaces || streetAddress.isAllSpaces || city.isAllSpaces || zip.isAllSpaces {
            return false
        }

        return true
    }

    var cost: Double {
        var cost = Double(quantity) * 5

//        cost += (Double(type) / 2)

        if extraFrosting {
            cost += Double(quantity)
        }

        if addSprinkles {
            cost += Double(quantity)
        }

        return cost
    }
}

// challenge 1
fileprivate extension String {

    var isAllSpaces: Bool {
        guard !self.isEmpty else { return false }
        return self.drop(while: { $0 == " " }).isEmpty
    }
}