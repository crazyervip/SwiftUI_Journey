//
//  Favorites.swift
//  26_Project19_SnowSeeker
//
//  Created by Jacob Zhang on 2020/5/14.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import Foundation

class Favorites: ObservableObject {
    // the actual resorts the user has favorited
    private var resorts: Set<String>

    // the key we're using to read/write in UserDefaults
    private let saveKey = "Favorites"

    init() {
        // load our saved data
        // challenge 2
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decodedData = try? JSONDecoder().decode(Set<String>.self, from: data) {
                self.resorts = decodedData
                return
            }
        }

        // still here? Use an empty array
        self.resorts = []
    }

    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    // adds the resort to our set, updates all views, and saves the change
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }

    // removes the resort from our set, updates all views, and saves the change
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }

    func save() {
        // write out our data
        // challenge 2
        if let encodedData = try? JSONEncoder().encode(resorts) {
            UserDefaults.standard.set(encodedData, forKey: saveKey)
        }

    }
}
