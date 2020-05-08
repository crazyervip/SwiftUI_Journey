//
//  EmojiRatingView.swift
//  14_Project11_Bookworm
//
//  Created by Jacob Zhang on 2020/5/3.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct EmojiRatingView: View {
    let rating: Int16
    
    var body: some View {
        switch rating {
        case 1:
            return
                Text("🤬")
            //                Image(systemName: "cloud.rain.fill")
        //                .foregroundColor(Color.red.opacity(0.2))
        case 2:
            return
                Text("😤")
            
            //                Image(systemName: "cloud.fill")
        //                .foregroundColor(Color.red.opacity(0.4))
        case 3:
            return
                Text("😐")
            
            //                Image(systemName: "cloud.sun.fill")
        //                .foregroundColor(Color.orange.opacity(0.6))
        case 4:
            return
                Text("😌")
            
            //                Image(systemName: "sun.min.fill")
        //                .foregroundColor(Color.yellow.opacity(0.8))
        default:
            return
                Text("😎")
            
            //                Image(systemName: "sun.max.fill")
            //                .foregroundColor(Color.yellow.opacity(1))
        }
    }
}

struct EmojiRatingView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRatingView(rating: 3)
    }
}
