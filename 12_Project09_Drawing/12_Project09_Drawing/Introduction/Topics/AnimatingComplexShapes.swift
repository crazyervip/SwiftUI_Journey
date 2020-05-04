//
//  AnimatingComplexShapes.swift
//  12_Project09_Drawing
//
//  Created by Jacob Zhang on 2020/5/3.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct CheckerBoard: Shape {
    var rows: Int
    var columns: Int

    public var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(Double(rows), Double(columns))
        }

        set {
            self.rows = Int(newValue.first)
            self.columns = Int(newValue.second)
        }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let rowSize = rect.height / CGFloat(rows)
        let columnSize = rect.width / CGFloat(columns)

        for row in 0..<rows {
            for column in 0..<columns {
                // colored squares
                if (row + column).isMultiple(of: 2) {
                    let startX = columnSize * CGFloat(column)
                    let startY = rowSize * CGFloat(row)

                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }

        return path
    }
}

struct AnimatingComplexShapes: View {
    @State private var rows = 4
    @State private var columns = 4

    var body: some View {
        CheckerBoard(rows: rows, columns: columns)
            .onTapGesture {
                withAnimation(.linear(duration: 3)) {
                    self.rows = 8
                    self.columns = 16
                }
        }
        .navigationBarTitle("Animating complex shapes", displayMode: .inline)
    }
}

struct AnimatingComplexShapes_Previews: PreviewProvider {
    static var previews: some View {
        AnimatingComplexShapes()
    }
}
