//
//  ContentView.swift
//  19_Project14_BucketList
//
//  Created by Jacob Zhang on 2020/5/6.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import LocalAuthentication
import MapKit
import SwiftUI

struct ContentView: View {
    @State private var isUnlocked = false

    // challenge 3
    @State private var showingAuthenticationAlert = false
    @State private var authenticationError = ""
    
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var showingEditScreen = false

    var body: some View {
        ZStack {
            if isUnlocked {
                // challenge 2
                ZStack {
                    
                    MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, annotations: locations)
                        .edgesIgnoringSafeArea(.all)

                    Circle()
                        .fill(Color.blue)
                        .opacity(0.3)
                        .frame(width: 32, height: 32)

                    VStack {
                        Spacer()

                        HStack {
                            Spacer()
                            Button(action: {
                                let newLocation = CodableMKPointAnnotation()
                                newLocation.coordinate = self.centerCoordinate
                                self.locations.append(newLocation)
                                self.selectedPlace = newLocation
                                self.showingEditScreen = true
                            }) {
                                // challenge 1
                                Image(systemName: "plus")
                                    .padding()
                                    .background(Color.black.opacity(0.8))
                                    .foregroundColor(.white)
                                    .font(.title)
                                    .clipShape(Circle())
                                    .padding(.trailing)
                            }
                        }
                    }
                }
                .alert(isPresented: $showingPlaceDetails) {
                    Alert(title: Text(selectedPlace?.title ?? "未知标题"),
                          message: Text(selectedPlace?.subtitle ?? "未知副标题"),
                          primaryButton: .default(Text("OK")),
                          secondaryButton: .default(Text("编辑")) {
                        self.showingEditScreen = true
                    })
                }
                .sheet(isPresented: $showingEditScreen, onDismiss: saveData) {
                    if self.selectedPlace != nil {
                        EditView(placemark: self.selectedPlace!)
                    }
                }
                .onAppear(perform: loadData)
            } else {
                Button("解锁你的收藏地点") {
                    self.authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                    // challenge 3
                    .alert(isPresented: $showingAuthenticationAlert) {
                        Alert(title: Text("认证失败"), message: Text(self.authenticationError), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
    
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func loadData() {
        let filename = getDocumentDirectory().appendingPathComponent("SavedPlaces")

        do {
            let data = try Data(contentsOf: filename)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        }
        catch {
            print("无法加载数据")
        }
    }

    func saveData() {
        do {
            let filename = getDocumentDirectory().appendingPathComponent("SavedPlaces")
            let data = try JSONEncoder().encode(self.locations)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        }
        catch {
            print("无法保存数据")
        }
    }

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate to unlock places"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    }
                    else {
                        // challenge 3
                        self.authenticationError = "\(authenticationError?.localizedDescription ?? "未知错误")"
                        self.showingAuthenticationAlert = true
                    }
                }
            }
        }
        else {
            // challenge 3
            self.authenticationError = "指纹/面容识别不可用"
            self.showingAuthenticationAlert = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
