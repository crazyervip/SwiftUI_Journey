//
//  ContentView.swift
//  18_Project13_Instafilter
//
//  Created by Jacob Zhang on 2020/5/5.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI
import SPAlert

struct ContentView: View {
    
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    
    @State private var currentFilter: CIFilter = CIFilter.vignette()
    @State private var filterIntensity = 0.5
    // challenge 3
    @State private var filterRadius = 0.5
    @State private var filterScale = 0.5
    
    @State private var showingImagePicker = false
    @State private var showingFilterSheet = false
    // challenge 1
    @State private var showingNoPictureOnSave = true
    
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    
    let context = CIContext()
    
    var body: some View {
        let intensity = Binding<Double>(
            get: { self.filterIntensity },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
        }
        )
        
        // challenge 3
        let radius = Binding<Double>(
            get: { self.filterRadius },
            set: {
                self.filterRadius = $0
                self.applyProcessing()
        }
        )
        
        // challenge 3
        let scale = Binding<Double>(
            get: { self.filterScale },
            set: {
                self.filterScale = $0
                self.applyProcessing()
        }
        )
        
        return NavigationView {
            ZStack {
                ColorfulGradient()
                    .opacity(0.3)
                    .blur(radius: 10)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    VStack {
                        
                        if image != nil {
                            Rectangle()
                                .foregroundColor(Color.clear)
                                .overlay(
                                    image?
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 5, x: 0, y: 5)
                            )
                                .overlay(
                                    VStack {
                                        Spacer()
                                        Button(action: {
                                            self.image = nil
                                        }) {
                                            Image(systemName: "xmark.circle.fill")
                                                .opacity(0.7)
                                                .font(.system(size: 30, weight: .bold, design: .rounded))
                                        }
                                        .padding()
                                    }
                                    .shadow(radius: 5, x: 0, y: 5)
                            )
                            
                            
                        } else {
                            placeholderImage()
                                .overlay(
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            self.showingImagePicker = true
                                            self.sourceType = .camera
                                            
                                        }) {
                                            Image(systemName: "camera")
                                                .opacity(0.8)
                                                .font(.system(size: 100, weight: .bold, design: .rounded))
                                        }
                                        Spacer()
                                        Button(action: {
                                            self.showingImagePicker = true
                                            self.sourceType = .photoLibrary
                                            
                                        }) {
                                            Image(systemName: "photo")
                                                .opacity(0.8)
                                                .font(.system(size: 100, weight: .bold, design: .rounded))
                                        }
                                        Spacer()
                                    }
                            )
                              .padding(.vertical)
                            .cornerRadius(20)
                            
                        }
                    }
                    .animation(.spring())
                    
                    // challenge 3
                    VStack {
                        if currentFilter.inputKeys.contains(kCIInputIntensityKey) {
                            HStack {
                                Text("强度")
                                Slider(value: intensity)
                            }
                        }
                        
                        if currentFilter.inputKeys.contains(kCIInputRadiusKey) {
                            HStack {
                                    Text("半径")
                                Slider(value: radius)
                            }
                        }
                        
                        if currentFilter.inputKeys.contains(kCIInputScaleKey) {
                            HStack {
                                    Text("比例")
                                Slider(value: scale)
                            }
                        }
                    }
                    .padding(.vertical)
                    
                    HStack {
                        // challenge 2
                        Button("\(currentFilter.formattedName)") {
                            self.showingFilterSheet = true
                        }
                        
                        Spacer()
                        
                        Button("保存") {
                            guard let processedImage = self.processedImage
                                else {
                                    // challenge 1
                                    //                            self.animateNoPictureMessage()
                                    return
                            }
                            
                            let imageSaver = ImageSaver()
                            imageSaver.successHandler = {
                                print("Success saving image")
                                // SPAlert
                                let alertView = SPAlertView(title: "已保存", message: nil, preset: SPAlertPreset.done)
                                alertView.duration = 1
                                alertView.haptic = .success
                                alertView.present()
                            }
                            imageSaver.errorHandler = {
                                print("Error saving image: \($0.localizedDescription)")
                                // SPAlert
                                let alertView = SPAlertView(title: "保存失败", message: nil, preset: SPAlertPreset.error)
                                alertView.duration = 1
                                alertView.haptic = .error
                                alertView.present()
                            }
                            imageSaver.writePhotoToAlbum(image: processedImage)
                        }
                            // 更直观
                            .disabled(showingNoPictureOnSave ? true : false)
                    }
                }
//                .compositingGroup()
                .padding([.horizontal, .bottom])
                .navigationBarTitle("Insta 滤镜")
                .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: self.$inputImage, sourceType: self.$sourceType)
                }
                .actionSheet(isPresented: $showingFilterSheet) {
                    ActionSheet(title: Text("选择一个滤镜"), buttons: [
                        .default(Text("晶块化")) { self.setFilter(CIFilter.crystallize()) },
                        .default(Text("边缘")) { self.setFilter(CIFilter.edges()) },
                        .default(Text("高斯模糊")) { self.setFilter(CIFilter.gaussianBlur()) },
                        .default(Text("像素化")) { self.setFilter(CIFilter.pixellate()) },
                        .default(Text("棕褐色调")) { self.setFilter(CIFilter.sepiaTone()) },
                        .default(Text("锐化")) { self.setFilter(CIFilter.unsharpMask()) },
                        .default(Text("晕映")) { self.setFilter(CIFilter.vignette()) },
                        .default(Text("漫画")) { self.setFilter(CIFilter.comicEffect()) },
                        .cancel()
                    ])
                }
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
        
        // challenge 1
        self.showingNoPictureOnSave = false
        
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            // challenge 3
            currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            // challenge 3
            currentFilter.setValue(filterScale * 100, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        // reset sliders
        self.filterIntensity = 0.5
        self.filterRadius = 0.5
        self.filterScale = 0.5
        loadImage()
    }
    
    // challenge 1
    //    func animateNoPictureMessage() {
    //        let duration = 0.75
    //
    //        withAnimation(.linear(duration: duration)) {
    //            self.showingNoPictureOnSave = true
    //        }
    //        // animating with a delay for the disappearance resulted in the
    //        // appearance animation not showing. using asyncAfter instead.
    //        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
    //            withAnimation(.linear(duration: duration)) {
    //                self.showingNoPictureOnSave = false
    //            }
    //        }
    //    }
}

// challenge 2
extension CIFilter {
    var formattedName: String {
        let removeCI = name.replacingOccurrences(of: "CI",
                                                 with: "",
                                                 range: name.range(of: name))
        
        let spaceOnUpperCase = removeCI.replacingOccurrences(of: "([A-Z])",
                                                             with: " $1",
                                                             options: .regularExpression,
                                                             range: removeCI.range(of: removeCI))
        
        return spaceOnUpperCase.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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

struct placeholderImage: View {
    var body: some View {
        Rectangle()
            .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.05)))
            //            .frame(width: 380, height: 380)
            .background(ColorfulGradient().opacity(0.1))
            .cornerRadius(20)
            .shadow(radius: 5, x: 0, y: 5)
    }
}

