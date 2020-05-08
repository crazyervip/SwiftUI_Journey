//
//  AstronautView.swift
//  11_Project08_Moonshot
//
//  Created by Jacob Zhang on 2020/5/3.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut

    let missions: [Mission]

    init(astronaut: Astronaut) {
        self.astronaut = astronaut

        var matches = [Mission]()

        let missions = missionData
        for mission in missions {
            if mission.crew.first(where: { $0.name == astronaut.id }) != nil {
                matches.append(mission)
            }
        }

        self.missions = matches
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)

                    Text(self.astronaut.description)
                        .padding()
                        // MARK:  使文字末尾不会省略
                        .layoutPriority(1)
                    
                    // Project 15 - Challenge 3
                    Text("Missions")
                        .hidden()
                        .frame(width: 0, height: 0)
                        .accessibility(label: Text("Missions"))

                    ForEach(self.missions) { mission in
                        HStack {
                            Image(mission.image)
                                .resizable()
                            .scaledToFit()
                                .frame(width: 75, height: 75)

                            Text(mission.displayName)
                                .font(.headline)

                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = astronautData

    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
