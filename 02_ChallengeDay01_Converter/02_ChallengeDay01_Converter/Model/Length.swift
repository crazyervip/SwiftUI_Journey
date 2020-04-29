//
//  Length.swift
//  02_ChallengeDay01_Converter
//
//  Created by Jacob Zhang on 2020/4/28.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import Foundation

struct Length: UnitType {
    static var name = "长度"
    
    private static let meters = NamedUnit(name: "米", unit: UnitLength.meters)
    private static let kilometers = NamedUnit(name: "千米", unit: UnitLength.kilometers)
    private static let feet = NamedUnit(name: "英尺", unit: UnitLength.feet)
    private static let yards = NamedUnit(name: "码", unit: UnitLength.yards)
    private static let miles = NamedUnit(name: "英里", unit: UnitLength.miles)

    static let units = [meters, kilometers, feet, yards, miles]
}
