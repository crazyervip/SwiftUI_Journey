//
//  UnitType.swift
//  02_ChallengeDay01_Converter
//
//  Created by Jacob Zhang on 2020/4/28.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import Foundation

/// 同一大类单位的小类单位
protocol UnitType {
    static var name: String { get }
    static var units: [NamedUnit] { get }
}
