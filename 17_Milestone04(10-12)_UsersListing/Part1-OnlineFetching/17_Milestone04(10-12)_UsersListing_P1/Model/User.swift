//
//  User.swift
//  17_Milestone04(10-12)_UsersListing_P1
//
//  Created by Jacob Zhang on 2020/5/4.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import Foundation

struct User: Codable, Identifiable {
    var id: String
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var friends: [Friend]
}
