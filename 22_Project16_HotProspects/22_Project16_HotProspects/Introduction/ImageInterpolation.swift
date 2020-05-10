//
//  ImageInterpolation.swift
//  22_Project16_HotProspects
//
//  Created by Jacob Zhang on 2020/5/10.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct ImageInterpolation: View {
    var body: some View {
        Image("example")
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
    }
}

struct ImageInterpolation_Previews: PreviewProvider {
    static var previews: some View {
        ImageInterpolation()
    }
}
