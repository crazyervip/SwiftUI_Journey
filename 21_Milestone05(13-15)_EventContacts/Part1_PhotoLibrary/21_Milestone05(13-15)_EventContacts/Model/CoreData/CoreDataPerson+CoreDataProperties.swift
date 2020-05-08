//
//  CoreDataPerson+CoreDataProperties.swift
//  21_Milestone05(13-15)_EventContacts
//
//  Created by Jacob Zhang on 2020/5/8.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//
//

import Foundation
import CoreData


extension CoreDataPerson {
    
    // createFetchRequest

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<CoreDataPerson> {
        return NSFetchRequest<CoreDataPerson>(entityName: "CoreDataPerson")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var imagePath: String?
    @NSManaged public var internalName: String?
    
    public var name: String {
        get {
            internalName ?? "Unknown name"
        }

        set {
            internalName = newValue
        }
    }

}
