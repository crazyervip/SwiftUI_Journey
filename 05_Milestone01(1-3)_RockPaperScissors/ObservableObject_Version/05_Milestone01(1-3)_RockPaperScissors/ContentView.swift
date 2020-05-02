//
//  ContentView.swift
//  05_Milestone01(1-3)_RockPaperScissors
//
//  Created by Jacob Zhang on 2020/4/30.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct GestureView: View {
    var gesture: Gesture
    
    var body: some View {
        switch gesture {
        case .rock:
            return Text("✊")
        case .paper:
            return Text("✋")
        case .scissors:
            return Text("✌️")
        }
    }
}

struct GoalView: View {
    var goal: Goal
    
    var body: some View {
        HStack {
            Text("如何")
            if goal == .win {
                Text("直接赢下")
                    .padding(EdgeInsets.init(top: 4, leading: 8, bottom: 4, trailing: 8))
                    .background(Color.green.opacity(0.8))
                    .clipShape(Capsule())
            }
            else {
                Text("故意输掉")
                    .padding(EdgeInsets.init(top: 4, leading: 8, bottom: 4, trailing: 8))
                    .background(Color.red.opacity(0.8))
                    .clipShape(Capsule())
            }
            Text("这局?")
        }.font(.headline)
    }
}

struct ContentView: View {
    @ObservedObject private var game = RockPaperScissors()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)),Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))]), startPoint: .bottomTrailing, endPoint: .topLeading)
                .opacity(0.78)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("石头剪刀布")
                .font(.largeTitle)
                    .padding()
                HStack {
                    Text("总分")
                    Text(String(game.score))
                        .font(.largeTitle)
                }.padding(10)
                    .padding(.horizontal)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)),Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))]), startPoint: .bottomTrailing, endPoint: .topLeading).opacity(1))
                    .cornerRadius(30)
                    .padding()
                GoalView(goal: game.goal)
                    .padding()
                GestureView(gesture: game.gesture)
                    .font(Font.system(size: 100))
                Spacer()
                
                HStack {
                    ForEach(Gesture.allCases, id: \.self) { gesture in
                        Button(action: {
                            self.game.submitAnswer(withGuess: gesture)
                        }, label: {
                            GestureView(gesture: gesture)
                                .font(Font.system(size: 50))
                                .padding()
                        })
                    }
                }
                                
                Button(action: {
                    self.game.mode = (self.game.mode == .normal ? .timed : .normal)
                }, label: {
                    Text(game.mode == .normal ? "无限模式" : "计时模式, 还剩 \(game.remainingTime, specifier: "%.0f")s")
                        .font(.system(size: 18, weight: .bold))
                })
                    .padding(10)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)),Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))]), startPoint: .bottomTrailing, endPoint: .topLeading))
                    .clipShape(Capsule())
                Spacer().frame(height: 100)
            }
            .foregroundColor(.white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//                    .colorScheme(.dark)
    }
}

