//
//  ContentView.swift
//  17_Milestone04(10-12)_UsersListing_P2
//
//  Created by Jacob Zhang on 2020/5/4.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) var users: FetchedResults<User>

    var body: some View {
        NavigationView {
            List {
                ForEach(users, id: \.id) { user in
                    NavigationLink(destination: DetailView(user: user)) {
                        VStack(alignment: HorizontalAlignment.leading) {
                            Text(user.uwName)
                                .font(.headline)
                            Text(user.uwEmail)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationBarTitle("Users")
        }
        .onAppear(perform: checkDataLoad)
    }

    func checkDataLoad() {
        if users.isEmpty {
            DataInitializer.loadData(moc: moc)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
