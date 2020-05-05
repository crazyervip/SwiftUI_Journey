//
//  ContentView.swift
//  11_Project08_Moonshot
//
//  Created by Jacob Zhang on 2020/5/3.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let missions: [Mission] = missionData
    let astronauts: [Astronaut] = astronautData

    @State var showDate = true

    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)

                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        if self.showDate {
                            Text(mission.formattedLaunchDate)
                                .font(.subheadline)
                        }
                        else {
                            Text(mission.crewNames(astronauts: self.astronauts))
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationBarTitle("登月计划")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showDate.toggle()
                }, label: {
                    HStack {
                        Image(systemName: "arrow.down")
                        Text("\(self.showDate ? "日期" : "成员")")
                    }
                })
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

