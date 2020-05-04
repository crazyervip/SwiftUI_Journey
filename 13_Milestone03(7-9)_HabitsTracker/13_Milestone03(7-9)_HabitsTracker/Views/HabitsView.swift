//
//  ContentView.swift
//  13_Milestone03(7-9)_HabitsTracker
//
//  Created by Jacob Zhang on 2020/5/3.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct HabitsView: View {
    @ObservedObject var habits = Habits()
    @State var showAddActivity = false

    var body: some View {
        NavigationView {
            List {
                ForEach(habits.activities) { activity in
                    NavigationLink(destination: EditActivity(habits: self.habits, activityId: activity.id)) {
                        VStack(alignment: .leading) {
                            Text(activity.title)
                                .font(.headline)
                            Text(activity.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            HStack {
                                Text("完成了")
                                Text("\(activity.completedTimes)")
                                    .padding(.horizontal, -5)
                                    .foregroundColor(activity.completedTimes > 0 ? .green : .red)
                                Text("次")
                            }
                            .font(.subheadline)
                        }
                    }
                }
                .onDelete { offsets in
                    self.habits.activities.remove(atOffsets: offsets)
                }
            }
            .navigationBarTitle("习惯养成")
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                    Button(action: {
                        self.showAddActivity = true
                    }) {
                        Image(systemName: "plus")
                            // increase tap area size
                            .padding(7)
                            .background(Color(.systemGray5))
                            .clipShape(Circle())
                            .frame(width: 44, height: 44)
                    }
            )
        }
        .sheet(isPresented: $showAddActivity) {
            AddActivity(habits: self.habits)
        }
    }
}

struct HabitsView_Previews: PreviewProvider {
    static var previews: some View {
        HabitsView()
    }
}
