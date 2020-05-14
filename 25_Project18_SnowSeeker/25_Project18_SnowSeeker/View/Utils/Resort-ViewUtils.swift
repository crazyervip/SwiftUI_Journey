//
//  Resort-ViewUtils.swift
//  25_Project18_ SnowSeeker
//
//  Created by Jacob Zhang on 2020/5/14.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

// challenge 3
extension Resort {
    var sizeText: String {
        Self.sizeText(from: size)
    }

    static func sizeText(from size: Int) -> String {
        switch size {
        case 1:
            return "Small"
        case 2:
            return "Average"
        default:
            return "Large"
        }
    }

    static func size(from sizeText: String) -> Int {
        switch sizeText {
        case "Small":
            return 1
        case "Average":
            return 2
        default:
            return 3
        }

    }

    var priceText: String {
        Self.priceText(from: price)
    }

    static func priceText(from price: Int) -> String {
        String(repeating: "$", count: price)
    }

    static func price(from priceText: String) -> Int {
        return priceText.count
    }
}
