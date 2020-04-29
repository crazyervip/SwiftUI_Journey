//
//  UnitType.swift
//  02_ChallengeDay01_Converter
//
//  Created by Jacob Zhang on 2020/4/28.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import Foundation

/// List of units of the same type
protocol UnitType {
    static var name: String { get }
    static var units: [NamedUnit] { get }
}
