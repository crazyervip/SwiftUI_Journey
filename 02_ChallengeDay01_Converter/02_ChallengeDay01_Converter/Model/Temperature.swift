//
//  Temperature.swift
//  02_ChallengeDay01_Converter
//
//  Created by Jacob Zhang on 2020/4/28.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import Foundation

struct Temperature: UnitType {
    static var name = "Temperature"
    
    private static let celsius = NamedUnit(name: "Celsius", unit: UnitTemperature.celsius)
    private static let farenheit = NamedUnit(name: "Farenheit", unit: UnitTemperature.fahrenheit)
    private static let kelvin = NamedUnit(name: "Kelvin", unit: UnitTemperature.kelvin)

    static let units = [celsius, farenheit, kelvin]
}
