//
//  MeView.swift
//  22_Project16_HotProspects
//
//  Created by Jacob Zhang on 2020/5/10.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
    @State private var name = "Jacob_d"
    @State private var emailAddress = "zjc8966@me.com"
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text(name)
                        .font(.system(size: 25))
                        .fontWeight(.semibold)
                    Text(emailAddress)
                        .foregroundColor(.secondary)
                    Image(uiImage: generateQRCode(from: "\(name)\n\(emailAddress)"))
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .cornerRadius(20)
                }
                .padding(40)
                .background(MyBackground())
                .padding()

                VStack {
                    TextField("姓名", text: $name)
                        .textContentType(.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                    TextField("邮箱", text: $emailAddress)
                        .textContentType(.emailAddress)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()
                .background(MyBackground())
                Spacer()
            }
            .padding()
            .navigationBarTitle("我的二维码")
        }
    }
    
    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}

struct ColorfulGradient: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)),Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)), Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))]), startPoint: .leading, endPoint: .trailing)
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)),Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)), Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))]), startPoint: .top, endPoint: .bottom)
        }
    }
}

struct MyBackground: View {
    var body: some View {
        Rectangle()
            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.1)))
            //            .frame(width: 380, height: 380)
            .background(ColorfulGradient().opacity(0.1))
            .cornerRadius(20)
            .shadow(radius: 5, x: 0, y: 5)
    }
}

