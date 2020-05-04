//
//  EditActivity.swift
//  13_Milestone03(7-9)_HabitsTracker
//
//  Created by Jacob Zhang on 2020/5/3.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct EditActivity: View {
    // binding the activity directly instead of passing habits + activityId would be cleaner
    // but @Binding has not yet been seen at this part of the 100 days of SwiftUI course
    // so here's a solution without it
    @ObservedObject var habits: Habits
    var activityId: UUID

    @State var completedTimes: Int = 0

    var activity: Activity {
        habits.getActivity(id: activityId)
    }

    var body: some View {
        Form {
            Text(activity.title)
            Text(activity.description)
            Stepper(
                onIncrement: { self.updateActivity(by: 1) },
                onDecrement: { self.updateActivity(by: -1) },
                label: { Text("Completed \(activity.completedTimes) times") }
            )
        }
        .navigationBarTitle("Edit Activity", displayMode: .inline)
    }

    func updateActivity(by change: Int) {
        var activity = self.activity
        activity.completedTimes += change
        self.habits.update(activity: activity)
    }
}

struct EditActivity_Previews: PreviewProvider {
    static var previews: some View {
        EditActivity(habits: Habits(), activityId: UUID())
    }
}
