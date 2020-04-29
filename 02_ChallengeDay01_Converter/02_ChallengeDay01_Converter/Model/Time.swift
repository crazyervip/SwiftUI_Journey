//
//  Time.swift
//  02_ChallengeDay01_Converter
//
//  Created by Jacob Zhang on 2020/4/28.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import Foundation

struct Time: UnitType {
    static var name = "时间"

    private static let seconds = NamedUnit(name: "秒", unit: UnitDuration.seconds)
    private static let minutes = NamedUnit(name: "分钟", unit: UnitDuration.minutes)
    private static let hours = NamedUnit(name: "小时", unit: UnitDuration.hours)

    static let units = [seconds, minutes, hours]
}
