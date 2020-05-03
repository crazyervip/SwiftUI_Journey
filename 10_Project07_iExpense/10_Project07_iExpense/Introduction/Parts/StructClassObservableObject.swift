//
//  StructClassObservableObject.swift
//  10_Project07_iExpense
//
//  Created by Jacob Zhang on 2020/5/2.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct User1 {
    var first = "结构体"
    var second = "strcuts"
}

class User2 {
    var first = "类"
    var second = "classes"
}

class User3: ObservableObject {
    @Published var first = "class:"
    @Published var second = "ObservableObject"
}

struct StructClassObservableObject: View {
    @State var user1 = User1()
    
    @State var user2 = User2()
    
    @ObservedObject var user3 = User3()
    
    var body: some View {
        List {
            Group {
                GeometryReader { gr1 in
                    // List中除以2 ScrollView除1
                    Image("GitPage")
                        .resizable()
                        .scaledToFill()
                        .offset(y: gr1.frame(in: .global).minY > 0 ? -gr1.frame(in: .global).minY/2 : 0)
                        .frame(width: UIScreen.main.bounds.width, height: gr1.frame(in: .global).minY > 0 ? 180 + gr1.frame(in: .global).minY : 180)
                }
                .frame(height: 180)
                
                .animation(.none)
                
                
                VStack {
                    Text("\(user1.first) \(user1.second)")
                        .font(.title)
                    
                    Text("UI 会实时刷新，因为每一次数据改变，Strcut 都会建立一个新的拷贝，而本身不会改变")
                        .frame(minHeight: 50)
                        .padding(.vertical, 10)
                        .foregroundColor(Color.secondary)
                    
                    HStack {
                        TextField("", text: $user1.first)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("", text: $user1.second)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                }
                .padding()
                .background(Color.red.opacity(0.2).cornerRadius(20))
                
                
                //                Spacer().frame(height: 100)
                
                VStack {
                    Text("\(user2.first) \(user2.second)")
                        .font(.title)
                    
                    Text("UI 在完全退出编辑后刷新（进入下一个编辑时），此时 class 本身已发生变化")
                        .frame(minHeight: 50)
                        .padding(.vertical, 10)
                        .foregroundColor(Color.secondary)
                    
                    HStack {
                        TextField("", text: $user2.first)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("", text: $user2.second)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    
                }
                .padding()
                .background(Color.blue.opacity(0.2).cornerRadius(20))
                

                
                VStack {
                    Text("\(user3.first) \(user3.second)")
                        .font(.title)
                    Text("UI 实时刷新，class 本身实时变化")
                        .frame(minHeight: 5)
                        .padding(.vertical, 10)
                        .foregroundColor(Color.secondary)
                    
                    HStack {
                        TextField("", text: $user3.first)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("", text: $user3.second)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    
                }
                .padding()
                .background(Color.green.opacity(0.2).cornerRadius(20))
                


            }
        }
        .modifier(KeyboardLiftsView())
        .disableAutocorrection(true)
        .edgesIgnoringSafeArea(.all)
    }
}

struct StructClassObservableObject_Previews: PreviewProvider {
    static var previews: some View {
        StructClassObservableObject()
//        .previewDevice("iPad Pro (11-inch)")
    }
}
