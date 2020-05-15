//
//  ResortDetailsView.swift
//  26_Project19_SnowSeeker
//
//  Created by Jacob Zhang on 2020/5/14.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct ResortDetailsView: View {
    let resort: Resort

    var body: some View {
        Group {
            Text("Size: \(resort.sizeText)").layoutPriority(1)
            Spacer().frame(height: 0)
            Text("Price: \(resort.priceText)").layoutPriority(1)
        }
    }
}

struct ResortDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ResortDetailsView(resort: Resort.example)
    }
}
