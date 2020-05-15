//
//  DeleteHistoryModifier.swift
//  25_Milestone06(16-18)_RollTheDice
//
//  Created by Jacob Zhang on 2020/5/12.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

/// Shows an ActionSheet on iPhones, an Alert on iPads
/// (ActionSheet is not working on ipad due to a SwiftUI bug)
struct DeleteHistoryModifier: ViewModifier {
    @Binding var showingAction: Bool
    var action: () -> Void
    
    private let title = Text("Delete history?")
    private let deleteButton = Text("Delete all")
    
    func body(content: Content) -> some View {
        return Group {
            if UIDevice.current.userInterfaceIdiom == .pad {
                content.alert(isPresented: $showingAction, content: {
                    Alert(title: title,
                          primaryButton: .destructive(deleteButton, action: action),
                          secondaryButton: .cancel())
                })
            }
            else {
                content.actionSheet(isPresented: $showingAction, content: {
                    ActionSheet(title: title, buttons: [
                        .destructive(deleteButton, action: action),
                        .cancel()]
                    )
                })
            }
        }
    }
}

