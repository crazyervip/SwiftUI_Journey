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
    
    
    //MARK: Project06_Challenge1
    @State private var spinAnimationAmounts = [0.0, 0.0, 0.0]
    @State private var animatingIncreaseScore = false
    @State private var animatingDecreaseScore = false
    
    //MARK: Project06_Challenge2
    @State var animateOpacity = false
    
    //MARK: Project06_Challenge3
    @State private var shakeAnimationAmounts = [0, 0, 0]
    @State private var wrongCountry = ""
    @State private var allowSubmitAnswer = true
    
    
    var body: some View {
        ZStack {
            // 背景
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text(animatingDecreaseScore || animatingIncreaseScore ? "这个国旗是" : "猜猜哪个国旗是")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .padding()
                        
                        .cornerRadius(20)
                    Text(animatingDecreaseScore ? "\(wrongCountry)" : countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .padding()
                        .background(animatingDecreaseScore ? Color.red.opacity(0.8) : (animatingIncreaseScore ? Color.green.opacity(0.8) : nil))
                        .cornerRadius(20)
                }
                .foregroundColor(.white)
                .animation(.none)
                
                HStack {
                    Text("总分：")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    ZStack {
                        //MARK: Project06_challenge1 & 3
                        Text("\(score)")
                            .foregroundColor(animatingIncreaseScore ? .green : (animatingDecreaseScore ? .red : .white))
                            .font(.title)
                        
                        //MARK: Project06_challenge1
                        Text("+1")
                            .font(.title)
                            .foregroundColor(animatingIncreaseScore ? .green : .clear)
                            .opacity(animatingIncreaseScore ? 0 : 1)
                            .offset(x: 0, y: animatingIncreaseScore ? -50 : -10)
                            .scaleEffect(animatingIncreaseScore ? 0.5 : 2.5)
                            .shadow(color: .black, radius: 5, x: 0, y: 5)
                        //MARK: Project06_challenge3
                        Text("-1")
                            .foregroundColor(animatingDecreaseScore ? .red : .clear)
                            .font(.title)
                            .opacity(animatingDecreaseScore ? 0 : 1)
                            .offset(x: 0, y: animatingDecreaseScore ? 50 : 10)
                            .scaleEffect(animatingDecreaseScore ? 0.5 : 2.5)
                        .shadow(color: .black, radius: 5, x: 0, y: 5)

                    }
                }
                .padding(10)
                    //MARK: cornerRadius 针对背景，不要针对 HStack，否则 offset 动画会被 clipped
                    .background(BlurBg(style: .systemUltraThinMaterial).cornerRadius(20))
                Spacer()
                ForEach(0 ..< 3) { number in
                    Flag(name: self.countries[number])
                        // project 6 - challenge 1
                        .rotation3DEffect(.degrees(self.spinAnimationAmounts[number]), axis: (x: 0, y: 1, z: 0))
                        // project 6 - challenge 3
                        .modifier(ShakeEffect(shakes: self.shakeAnimationAmounts[number] * 2))
                        .opacity(self.animateOpacity ? (number == self.correctAnswer ? 1 : 0.25) : 1)
                        .onTapGesture {
                            self.flagTapped(number)
                    }
                }
                Spacer()
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        //MARK: Project06_challenge1
        guard allowSubmitAnswer else { return }
        allowSubmitAnswer = false
        
        //MARK: Project06_challenge1
        let nextQuestionDelay = 1.5
        let flagAnimationDuration = 0.5
        let scoreUpdateDuration = 1.5
        
        //MARK: Project06_challenge2
        withAnimation(Animation.easeInOut(duration: flagAnimationDuration)) {
            self.animateOpacity = true
        }
        
        if number == correctAnswer {
            score += 1
            //MARK: Project06_challenge1
            withAnimation(Animation.easeInOut(duration: flagAnimationDuration)) {
                self.spinAnimationAmounts[number] += 360
            }
            withAnimation(Animation.linear(duration: scoreUpdateDuration)) {
                self.animatingIncreaseScore = true
            }
        }
        else {
            wrongCountry = countries[number]
            score -= 1
            //MARK: Project06_challenge3
            withAnimation(Animation.easeInOut(duration: flagAnimationDuration)) {
                self.shakeAnimationAmounts[number] = 2
            }
            withAnimation(Animation.linear(duration: scoreUpdateDuration)) {
                self.animatingDecreaseScore = true
            }
        }
        
        //MARK: Project06_challenge1
        DispatchQueue.main.asyncAfter(deadline: .now() + nextQuestionDelay) {
            self.askQuestion()
        }
    }
    
    func askQuestion() {
        //MARK: Project06_challenge1
        self.spinAnimationAmounts = [0.0, 0.0, 0.0]
        self.animatingIncreaseScore = false
        //MARK: Project06_challenge2
        self.animateOpacity = false
        //MARK: Project06_challenge3
        self.shakeAnimationAmounts = [0, 0, 0]
        self.animatingDecreaseScore = false
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        //MARK: Project06_challenge1
        allowSubmitAnswer = true
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

//MARK: Project06_Animations
// 抖动效果 https://talk.objc.io/episodes/S01E173-building-a-shake-animation
struct ShakeEffect: GeometryEffect {
    func effectValue(size: CGSize) -> ProjectionTransform {
        return ProjectionTransform(CGAffineTransform(translationX: -30 * sin(position * 2 * .pi), y: 0))
    }
    
    init(shakes: Int) {
        position = CGFloat(shakes)
    }
    
    var position: CGFloat
    var animatableData: CGFloat {
        get { position }
        set { position = newValue }
    }
}
