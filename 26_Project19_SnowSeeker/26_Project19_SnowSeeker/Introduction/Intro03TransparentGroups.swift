//
//  Intro03TransparentGroups.swift
//  26_Project19_SnowSeeker
//
//  Created by Jacob Zhang on 2020/5/14.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna, Arya, and Toby")
        }
    }
}

struct Intro03TransparentGroups: View {
    @State var layoutVertically = false
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        TabView {
            Group {
                if layoutVertically {
                    VStack {
                        UserView()
                    }
                } else {
                    HStack {
                        UserView()
                    }
                }
            }
            .onTapGesture {
                self.layoutVertically.toggle()
            }
            .tabItem { Image(systemName: "1.circle") }

            Group {
                if sizeClass == .compact {
                    VStack {
                        UserView()
                    }
                } else {
                    HStack {
                        UserView()
                    }
                }
            }
            .tabItem { Image(systemName: "2.circle") }

            // same as 2 but with more compact code
            Group {
                if sizeClass == .compact {
                    VStack(content: UserView.init)
                } else {
                    HStack(content: UserView.init)
                }
            }
            .tabItem { Image(systemName: "3.circle") }
        }
    }
}

struct Intro03TransparentGroups_Previews: PreviewProvider {
    static var previews: some View {
        Intro03TransparentGroups()
    }
}
