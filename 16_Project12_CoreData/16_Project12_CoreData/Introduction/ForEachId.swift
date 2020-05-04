//
//  ForEachId.swift
//  16_Project12_CoreData
//
//  Created by Jacob Zhang on 2020/5/4.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct Student: Hashable {
    let name: String
}

struct ForEachId: View {
    let students = [Student(name: "Harry Potter"), Student(name: "Hermione Granger")]

    var body: some View {
        List(students, id: \.self) { student in
            Text(student.name)
        }
    }
}

struct ForEachID_Previews: PreviewProvider {
    static var previews: some View {
        ForEachId()
    }
}
