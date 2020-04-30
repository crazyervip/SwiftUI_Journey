//
//  CustomContainers.swift
//  04_Project03_ViewsAndModifiers
//
//  Created by Jacob Zhang on 2020/4/30.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let spacing: CGFloat
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack(spacing: spacing) {
            ForEach(0 ..< rows) { row in
                HStack (spacing: self.spacing) {
                    ForEach(0 ..< self.columns) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
    
    // allows several views inside the GridStack, without having to ressort to a HStack
    init(rows: Int, columns: Int, spacing: CGFloat, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.spacing = spacing
        self.content = content
    }
}

struct CustomContainers: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(0 ..< 5) { item in
                        Section (header: HStack {
                            Text("Section \(item+1)")
                                .padding(.horizontal)
                            Spacer()
                        }) {
                            GridStack(rows: 3, columns: 3, spacing: 5) { row, col in
                                Rectangle()
                                    .foregroundColor(Color.clear)
                                    .frame(minWidth: UIScreen.main.bounds.width/3)
                                    .frame(minHeight: UIScreen.main.bounds.width/3).background(Color.orange.opacity(0.2))
                                    .background(VStack {
                                        Image(systemName: "\(row * 3 + col+1).circle")
                                        Text("R\(row+1) C\(col+1)")
                                    }.font(.system(size: 18, weight: .semibold))
                                        .padding()
                                        .background(Color.red.opacity(0.3))
                                )
                            }
                        }
                    }
                }
            }.navigationBarTitle("Grid View")
        }
    }
}

struct CustomContainers_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CustomContainers()
                .previewDevice("iPhone 8")
            CustomContainers()
                .previewDevice("iPhone 11")
        }
    }
}
