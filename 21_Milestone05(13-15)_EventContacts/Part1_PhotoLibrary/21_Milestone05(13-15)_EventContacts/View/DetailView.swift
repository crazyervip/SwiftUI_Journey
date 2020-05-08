//
//  DetailView.swift
//  21_Milestone05(13-15)_EventContacts
//
//  Created by Jacob Zhang on 2020/5/8.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    var person: Person

    var body: some View {
        getImage(for: person)
            .resizable()
            .scaledToFit()
            // for placeholders
            .foregroundColor(Color.secondary)
            .navigationBarTitle(Text(person.name), displayMode: .inline)
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

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(person: Person(name: "Tim Cook"))
    }
}
