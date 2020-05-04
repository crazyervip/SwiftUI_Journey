//
//  DetailView.swift
//  17_Milestone04(10-12)_UsersListing_P1
//
//  Created by Jacob Zhang on 2020/5/4.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct FriendView: View {
    @ObservedObject var users: Users
    var friend: Friend

    var body: some View {
        if let foundFriend = self.users.find(withId: friend.id) {
            return AnyView(LinkedFriendView(users: users, friend: foundFriend))
        }
        else {
            return AnyView(Text(friend.name))
        }
    }
}

struct LinkedFriendView: View {
    @ObservedObject var users: Users
    var friend: User

    var body: some View {
        NavigationLink(destination: DetailView(users: users, user: friend)) {
            VStack(alignment: HorizontalAlignment.leading) {
                Text(friend.name)
                    .font(.headline)
                Text(friend.email)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct DetailView: View {
    @ObservedObject var users: Users
    var user: User

    var body: some View {
        List {
            Section(header: Text("Name")) {
                Text(user.name)
            }
            Section(header: Text("Age")) {
                Text(String(user.age))
            }
            Section(header: Text("Company")) {
                Text(user.company)
            }
            Section(header: Text("Email")) {
                Text(user.email)
            }
            Section(header: Text("Address")) {
                Text(user.address)
            }
            Section(header: Text("Friends")) {
                ForEach(user.friends) { friend in
                    FriendView(users: self.users, friend: friend)
                }
            }
        }
        .navigationBarTitle("\(user.name)", displayMode: .inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static let john = User(id: "123", name: "John Smith", age: 54, company: "Apple", email: "john.smith@apple.com", address: "Cupertino", friends: [])

    static var previews: some View {
        DetailView(users: Users(users: [john]), user: john)
    }
}
