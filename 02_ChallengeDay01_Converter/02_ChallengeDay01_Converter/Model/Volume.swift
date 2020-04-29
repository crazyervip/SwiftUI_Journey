//
//  Volume.swift
//  02_ChallengeDay01_Converter
//
//  Created by Jacob Zhang on 2020/4/28.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import Foundation

struct Volume: UnitType {
    static var name = "体积"

    private static let milliliters = NamedUnit(name: "毫升", unit: UnitVolume.milliliters)
    private static let liters = NamedUnit(name: "升", unit: UnitVolume.liters)
    private static let cups = NamedUnit(name: "杯", unit: UnitVolume.cups)
    private static let pints = NamedUnit(name: "品脱", unit: UnitVolume.pints)
    private static let gallons = NamedUnit(name: "加仑", unit: UnitVolume.gallons)

    static let units = [milliliters, liters, cups, pints, gallons]
}
