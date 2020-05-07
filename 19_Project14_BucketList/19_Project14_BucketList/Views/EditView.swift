//
//  EditView.swift
//  19_Project14_BucketList
//
//  Created by Jacob Zhang on 2020/5/6.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import MapKit
import SwiftUI
import SDWebImageSwiftUI



enum LoadingState {
    case loading, loaded, failed
}

struct EditView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var placemark: MKPointAnnotation

    @State private var loadingState = LoadingState.loading

    @State private var pois = [Poi]()
    
    @State private var showActionSheet = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("地点名称", text: $placemark.wrappedTitle)
                    TextField("描述", text: $placemark.wrappedSubtitle)
                }
                Section(header: Text("附近 1 公里...")) {
                    if loadingState == .loaded {
                        List(pois, id: \.id) { poi in
                            HStack {
                                WebImage(url: poi.photos.count != 0 ? URL(string: poi.photos[0].url) : URL(string: ""))
                                    .placeholder {
                                        Image(systemName: "photo")
                                            .font(.system(size: 50))
                                            .frame(width: 80, height: 80)
                                            .background(Color.secondary.opacity(0.2))
                                }
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipped()
                                .transition(.fade)
                                .cornerRadius(10)
                                    .padding(5)
                                
                                VStack (alignment: .leading, spacing: 5) {
                                    Text(poi.name)
                                        .font(.headline)
                                    .minimumScaleFactor(0.9)
                                    HStack(spacing: 0) {
                                        Text("🗺：")
                                        Text(poi.address)
                                            .foregroundColor(.secondary)
                                        .minimumScaleFactor(0.8)
                                    }
                                    HStack(spacing: 0) {
                                        Text("📞：")
//                                        Button(action: {
//                                            self.showActionSheet = true
//                                        }){
                                            Text(poi._tel)
                                        .minimumScaleFactor(0.7)
                                                
//                                        }
//                                        AttributedText(NSAttributedString(string: poi._tel))
                                    }
                                }
                                
                                Spacer()
                                Text("\(poi.distance)米")
                                    .font(.caption)
                            }
                        }
                    } else if loadingState == .loading {
                        Text("加载中…")
                    } else {
                        Text("请稍后再试")
                    }
                }
            }
            .navigationBarTitle("编辑地点")
            .navigationBarItems(trailing: Button("完成") {
                self.presentationMode.wrappedValue.dismiss()
            })
                .onAppear(perform: fetchNearbyPlaces)
                .onDisappear {
                    if self.placemark.wrappedTitle.isEmpty { self.placemark.wrappedTitle = "未知标题" }
                    if self.placemark.wrappedSubtitle.isEmpty { self.placemark.wrappedSubtitle = "未知描述" }
            }
        }
    }
    
    func fetchNearbyPlaces() {
        let urlLongitude = placemark.coordinate.longitude
        let urlLatitude = placemark.coordinate.latitude
        
        
        let urlString =
        "https://restapi.amap.com/v3/place/around?key=1fbad17480c3b7baaa0fb9cb86e46376&location=\(urlLongitude),\(urlLatitude)&radius=5000&sortrule=weight&offset=25&output=json"
        
        
        guard let url = URL(string: urlString) else {
            print("Incorrect URL: \(urlString)")
            return
        }
        
//        print(urlString)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let items = try decoder.decode(Result.self, from: data)
                    self.pois = items.pois
                    print(items.pois)
                    self.loadingState = .loaded
                    return
                }
                catch {
                    print(
                        """
                        Decoding failed.
                        - Data: \(String(bytes: data, encoding: .utf8) ?? "")
                        - Error: \(error.localizedDescription)
                        """
                    )
                }

            }


            if let error = error {
                print("Request failed: \(error.localizedDescription)")
            }

            self.loadingState = .failed
        }
        .resume()
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(placemark: MKPointAnnotation.example)
    }
}

//struct AttributedText: UIViewRepresentable {
//    var attributedText: NSAttributedString
//
//    init(_ attributedText: NSAttributedString) {
//        self.attributedText = attributedText
//    }
//
//    func makeUIView(context: Context) -> UITextView {
//        return UITextView()
//    }
//
//    func updateUIView(_ label: UITextView, context: Context) {
//        label.attributedText = attributedText
//    }
//}
