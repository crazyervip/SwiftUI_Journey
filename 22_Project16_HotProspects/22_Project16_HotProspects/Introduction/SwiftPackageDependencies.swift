//
//  SwiftPackageDependencies.swift
//  22_Project16_HotProspects
//
//  Created by Jacob Zhang on 2020/5/10.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SamplePackage
import SwiftUI

struct SwiftPackageDependencies: View {
    let possibleNumbers = Array(1...60)

    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }

    var body: some View {
        Text(results)
    }
}

struct SwiftPackageDependencies_Previews: PreviewProvider {
    static var previews: some View {
        SwiftPackageDependencies()
    }
}
