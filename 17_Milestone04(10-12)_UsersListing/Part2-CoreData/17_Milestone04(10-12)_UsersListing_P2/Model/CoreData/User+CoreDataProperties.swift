//
//  User+CoreDataProperties.swift
//  17_Milestone04(10-12)_UsersListing_P2
//
//  Created by Jacob Zhang on 2020/5/4.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var email: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var company: Company?
    @NSManaged public var friend: NSSet?
    
    public var uwName: String {
        name ?? "Unknown name"
    }

    public var uwEmail: String {
        email ?? "Unknown email"
    }

    public var uwAddress: String {
        address ?? "Unknown address"
    }

    public var uwCompanyName: String {
        company?.uwName ?? "Unkown company"
    }

    public var friendsArray: [User] {
        let set = friend as? Set<User> ?? []

        return set.sorted { $0.uwName < $1.uwName }
    }

}

// MARK: Generated accessors for friend
extension User {

    @objc(addFriendObject:)
    @NSManaged public func addToFriend(_ value: User)

    @objc(removeFriendObject:)
    @NSManaged public func removeFromFriend(_ value: User)

    @objc(addFriend:)
    @NSManaged public func addToFriend(_ values: NSSet)

    @objc(removeFriend:)
    @NSManaged public func removeFromFriend(_ values: NSSet)

}
