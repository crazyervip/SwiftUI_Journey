//
//  ShowHideViews.swift
//  10_Project07_iExpense
//
//  Created by Jacob Zhang on 2020/5/2.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct SecondView: View {
    @Environment(\.presentationMode) var presentationMode

    var name: String

    var body: some View {
        VStack {
            Text("Hello, \(name)")

            Button("Dismiss") {
                self.presentationMode.wrappedValue.dismiss()
            }
            .offset(x: 0, y: 20)
        }
    }
}

struct ShowHideViews: View {
    @State private var showingSheet = false

    var body: some View {
        Button("Show Sheet") {
            self.showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView(name: "Second View")
        }
    }
}

struct ShowHideViews_Previews: PreviewProvider {
    static var previews: some View {
        ShowHideViews()
    }
}
