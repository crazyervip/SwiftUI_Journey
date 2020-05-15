//
//  CoreDataRoll+CoreDataProperties.swift
//  25_Milestone06(16-18)_RollTheDice
//
//  Created by Jacob Zhang on 2020/5/12.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//
//

import Foundation
import CoreData


extension CoreDataRoll {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<CoreDataRoll> {
        return NSFetchRequest<CoreDataRoll>(entityName: "CoreDataRoll")
    }

    @NSManaged public var diceSides: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var total: Int16
    @NSManaged public var date: Date?
    @NSManaged public var result: [Int16]?

}
