//
//  ContentView.swift
//  17_Milestone04(10-12)_UsersListing_P1
//
//  Created by Jacob Zhang on 2020/5/4.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var users = Users()

    var body: some View {
        NavigationView {
            List {
                ForEach(users.all) { user in
                    NavigationLink(destination: DetailView(users: self.users, user: user)) {
                        VStack(alignment: HorizontalAlignment.leading) {
                            Text(user.name)
                                .font(.headline)
                            Text(user.email)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationBarTitle("Users")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let john = User(id: "123", name: "John Smith", age: 54, company: "Apple", email: "john.smith@apple.com", address: "Cupertino", friends: [])

    static var previews: some View {
        ContentView(users: Users(users: [john]))
    }
}
