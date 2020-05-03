//
//  SwiftUIView.swift
//  10_Project07_iExpense
//
//  Created by Jacob Zhang on 2020/5/3.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct SwiftUIView: View {
    @State var tf = ""
    
    var body: some View {
        VStack {
            Spacer()
            TextField(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/, text: $tf)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .padding(.bottom)
        }
        .modifier(KeyboardLiftsView())
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
