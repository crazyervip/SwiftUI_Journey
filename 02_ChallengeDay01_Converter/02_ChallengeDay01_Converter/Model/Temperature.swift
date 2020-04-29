//
//  Temperature.swift
//  02_ChallengeDay01_Converter
//
//  Created by Jacob Zhang on 2020/4/28.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import Foundation

struct Temperature: UnitType {
    static var name = "温度"
    
    private static let celsius = NamedUnit(name: "摄氏度", unit: UnitTemperature.celsius)
    private static let farenheit = NamedUnit(name: "华氏度", unit: UnitTemperature.fahrenheit)
    private static let kelvin = NamedUnit(name: "开尔文", unit: UnitTemperature.kelvin)

    static let units = [celsius, farenheit, kelvin]
}
