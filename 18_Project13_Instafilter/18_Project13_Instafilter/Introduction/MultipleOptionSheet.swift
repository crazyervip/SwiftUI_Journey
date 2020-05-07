//
//  MultipleOptionSheet.swift
//  18_Project13_Instafilter
//
//  Created by Jacob Zhang on 2020/5/5.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct MultipleOptionSheet: View {
    @State private var showingActionSheet = false
    @State private var backgroundColor = Color.white

    var body: some View {
        Text("Hello, World!")
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .onTapGesture {
                self.showingActionSheet = true
        }
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text("Change background"), message: Text("Select a new color"), buttons: [
                .default(Text("Red"), action: { self.backgroundColor = .red }),
                .default(Text("Green"), action: { self.backgroundColor = .green }),
                .default(Text("Blue"), action: { self.backgroundColor = .blue }),
                .cancel()
            ])
        }
    }
}

struct MultipleOptionSheet_Previews: PreviewProvider {
    static var previews: some View {
        MultipleOptionSheet()
    }
}
