//
//  MKPointAnnotation+ObservableObject.swift
//  19_Project14_BucketList
//
//  Created by Jacob Zhang on 2020/5/6.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import MapKit

extension MKPointAnnotation: ObservableObject {

    // no need for published as view doesn't need to be refreshed as the user type
    public var wrappedTitle: String {
        get {
            self.title ?? ""
        }
        set {
            title = newValue
        }
    }

    // no need for published as view doesn't need to be refreshed as the user type
    public var wrappedSubtitle: String {
        get {
            self.subtitle ?? ""
        }
        set {
            subtitle = newValue
        }
    }
}
