//
//  AddContact.swift
//  21_Milestone05(13-15)_EventContacts
//
//  Created by Jacob Zhang on 2020/5/8.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct AddContact: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var persons: Persons

    @State private var name: String = ""

    @State private var showingImagePicker = false
    @State private var uiImage: UIImage?
    @State private var image: Image?
    
//    @State private var showingErrorAlert = false
//    @State private var errorAlertMessage = ""

//    @State private var showingEmptyNameAlert = false
    
    @State private var isCameraAvailable = true
    
    @State private var isPhotoLibraryAvailable = true
    
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    
    private let locationFetcher = LocationFetcher()

    
    var body: some View {
        NavigationView {
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
                                            .opacity(0.8)
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
                                        self.takePicture()
                                    }) {
                                        Image(systemName: "camera")
                                            .opacity(0.8)
                                            .font(.system(size: 100, weight: .bold, design: .rounded))
                                    }
                                    .shadow(radius: 15, x: 0, y: 5)
                                    .disabled(!isCameraAvailable ? true : false)
                                    Spacer()
                                    Button(action: {
                                        self.selectPhoto()
                                    }) {
                                        Image(systemName: "photo")
                                            .opacity(0.8)
                                            .font(.system(size: 100, weight: .bold, design: .rounded))
                                    }
                                    .shadow(radius: 15, x: 0, y: 5)
                                    .disabled(!isPhotoLibraryAvailable ? true : false)

                                    Spacer()
                                }
                        )
                          .padding(.vertical)
                        .cornerRadius(20)
                        
                    }
                    }
                    .frame(minHeight: 400, maxHeight: 600)
                placeholderImage()
                    .opacity(0.7)
                    .overlay(
                        TextField("姓名", text: $name)
                            .padding(Edge.Set.leading, 20)
                )
                    
                .frame(height: 50)
                
                Spacer()

                }
            .padding(.horizontal)
                
            .modifier(KeyboardLiftsView())
                
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$uiImage, sourceType: self.$sourceType)
            }
//            .alert(isPresented: $showingEmptyNameAlert, content: {
//                Alert(title: Text("请填写姓名"))
//            })
            .navigationBarTitle(Text("添加联系人"), displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: { self.addContact() },
                       label: { Text("确认").padding(15) }
                )
                    .disabled(name.isEmpty ? true : false)
            )
            .onAppear() {
                self.locationFetcher.start()
                self.checkCamera()
            }
        }
    }

    func loadImage() {
        guard let uiImage = self.uiImage else { return }
        self.image = Image(uiImage: uiImage)
    }
    
    func checkCamera() {
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            isCameraAvailable = false
        } else if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            isPhotoLibraryAvailable = false
        }
    }

    func takePicture() {
            self.sourceType = .camera
            self.showingImagePicker = true
    }

    func selectPhoto() {
        self.sourceType = .photoLibrary
        self.showingImagePicker = true
    }

    func addContact() {
//        guard !self.name.isEmpty else {
//            errorAlertMessage = "Please provide a name"
//            showingErrorAlert = true
//            return
//        }

        var person = Person(name: self.name)

        if let uiImage = uiImage {
            if let jpegData = uiImage.jpegData(compressionQuality: 0.8) {
                person.setImage(image: jpegData)
            }
        }

        if let location = self.locationFetcher.lastKnownLocation {
            person.latitude = location.latitude
            person.longitude = location.longitude
            person.locationRecorded = true
        }
        else {
            person.locationRecorded = false
        }

        self.persons.add(person: person)
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddContact_Previews: PreviewProvider {
    static var previews: some View {
        AddContact(persons: Persons())
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
            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.1)))
            //            .frame(width: 380, height: 380)
            .background(ColorfulGradient().opacity(0.1))
            .cornerRadius(20)
            .shadow(radius: 5, x: 0, y: 5)
    }
}
