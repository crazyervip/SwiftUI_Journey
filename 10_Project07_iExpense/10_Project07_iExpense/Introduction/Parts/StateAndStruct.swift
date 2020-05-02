//
//  StateAndStruct.swift
//  10_Project07_iExpense
//
//  Created by Jacob Zhang on 2020/5/2.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct User1 {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}

class User2 {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}

struct StateAndStruct: View {
    @State var user1 = User1()
    @State var user2 = User2()

    var body: some View {
        VStack {
            VStack {
                Text("Struct (changes are reflected as the property gets a new instance with each change)")

                Text("Your name is \(user1.firstName) \(user1.lastName)")

                TextField("First name", text: $user1.firstName)
                TextField("Last name", text: $user1.lastName)
            }
            .offset(x: 0, y: -50)

            VStack {
                Text("Class (changes are not reflected as the property never gets a new instance)")
                Text("Your name is \(user2.firstName) \(user2.lastName)")

                TextField("First name", text: $user2.firstName)
                TextField("Last name", text: $user2.lastName)
            }
            .offset(x: 0, y: 50)
        }
    }
}

struct StateAndStruct_Previews: PreviewProvider {
    static var previews: some View {
        StateAndStruct()
    }
}
