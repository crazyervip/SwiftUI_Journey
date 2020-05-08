//
//  DetailView.swift
//  21_Milestone05(13-15)_EventContacts
//
//  Created by Jacob Zhang on 2020/5/8.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import MapKit
import SwiftUI

struct DetailView: View {
    @State private var pickerTab = 0
    var person: Person

    var body: some View {
        VStack (spacing: 0) {
            Picker("", selection: $pickerTab) {
                Text("照片").tag(0)
                Text("位置").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            if pickerTab == 0 {
                getImage(for: person)
                    .resizable()
                    .scaledToFit()
                    // for placeholders
                    .foregroundColor(Color.gray)
                    .tag(0)
            }
            else {
                if person.locationRecorded {
                    MapView(annotation: getAnnotation())
                    .edgesIgnoringSafeArea(.all)

                }
                else {
                    Text("暂无位置信息")
                        .padding()
                }
            }

            Spacer()
        }
            .edgesIgnoringSafeArea(.bottom)
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

    func getAnnotation() -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: person.latitude, longitude: person.longitude)
        return annotation
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(person: Person(name: "Tim Cook"))
    }
}
