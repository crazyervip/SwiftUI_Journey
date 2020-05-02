//
//  ContentView.swift
//  03_Project02_GuessTheFlag
//
//  Created by Jacob Zhang on 2020/5/1.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI
import SPAlert

struct ContentView: View {
    @State private var countries = ["爱沙尼亚", "法国", "德国", "爱尔兰", "意大利", "尼日利亚", "波兰", "俄罗斯", "西班牙", "英国", "美国", "摩纳哥"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    
    @State private var scoreTitle = ""
    
    @State private var score = 0
    
    var body: some View {
        ZStack {
            // 背景
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("猜猜哪个国旗是")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .padding()
                }
                //                .background(Color.red.opacity(0.5))
                Text("总分: \(score)")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .background(BlurBg(style: .systemUltraThinMaterial))
                    .cornerRadius(20)
                Spacer()
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        //MARK: Project03_Challenge3
                        Flag(name: self.countries[number])
                    }
                }
                Spacer()
            }
        }
        //        .alert(isPresented: $showingScore) {
        //            Alert(title: Text(scoreTitle), message: Text("你的得分是  \(self.score)") /* challenge 1 */, dismissButton: .default(Text("继续")) {
        //                self.askQuestion()
        //                })
        //        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "正确 得分+1"
            score += 1
            
            // SPAlert
            let alertView = SPAlertView(title: "正确", message: "得分+1", preset: SPAlertPreset.done)
            alertView.duration = 1
            alertView.haptic = .success
            alertView.present()
            
            // 进入下一道题
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
        else {
            scoreTitle = "错误，得分−1\n这是\(countries[number])的国旗"
            score -= 1
            
            // SPAlert
            let alertView = SPAlertView(title: "错误", message: "得分−1\n这是\(countries[number])的国旗", preset: SPAlertPreset.error)
            alertView.duration = 1
            alertView.haptic = .error
            alertView.present()
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//MARK: 模糊背景
struct BlurBg: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

//MARK: Project03_Challenge3

struct Flag: View {
    var name: String
    
    var body: some View {
        Image(name)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}


