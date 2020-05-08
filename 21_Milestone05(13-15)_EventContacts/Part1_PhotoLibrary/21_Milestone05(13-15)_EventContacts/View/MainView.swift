//
//  MainView.swift
//  21_Milestone05(13-15)_EventContacts
//
//  Created by Jacob Zhang on 2020/5/8.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var persons: Persons
    @State var showingAddContact = false

    init(persons: Persons) {
        self.persons = persons
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(persons.all) { person in
                    NavigationLink(destination: DetailView(person: person)) {
                        self.getImage(for: person)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipped()
                            .cornerRadius(10)
                            // for placeholders
                            .foregroundColor(Color.gray)
                        Text(person.name)
                    }
                }
                .onDelete { offsets in
                    var persons = [Person]()
                    for offset in offsets {
                        persons.append(self.persons.all[offset])
                    }
                    self.persons.remove(persons: persons)
                }
            }
            .navigationBarTitle("活动联系人")
            .navigationBarItems(leading: EditButton(), trailing:
                Button(action: {
                    self.showingAddContact = true
                }) {
                    Image(systemName: "plus")
                        // increase tap area size
                        .padding(7)
                        .background(Color(.systemGray5))
                        .clipShape(Circle())
                        .padding(7)
                }
            )
        }
        .sheet(isPresented: $showingAddContact) {
            AddContact(persons: self.persons)
        }
    }

    func getImage(for person: Person) -> Image {
        if let imageData = person.getImage() {
            if let uiImage = UIImage(data: imageData) {
                return Image(uiImage: uiImage)
            }
        }

        return Image(systemName: "person.crop.square")
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(persons: Persons())
    }
}
