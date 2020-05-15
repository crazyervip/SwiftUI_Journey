//
//  View-PhoneOnlyStackNavigationView.swift
//  26_Project19_SnowSeeker
//
//  Created by Jacob Zhang on 2020/5/14.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}
