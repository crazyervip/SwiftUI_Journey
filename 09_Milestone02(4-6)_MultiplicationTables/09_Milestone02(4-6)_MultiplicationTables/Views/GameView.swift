//
//  GameView.swift
//  09_Milestone02(4-6)_MultiplicationTables
//
//  Created by Jacob Zhang on 2020/5/1.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var settings: Settings
    @ObservedObject var settingsToggle: SettingsToggle
    
    @State private var questions = [Question]()
    @State private var currentQuestion = 0
    @State private var answer = ""
    @State private var gameInProgress = false
    
    @State private var score = 0
    
    @State private var animatingIncreaseScore = false
    @State private var animatingDecreaseScore = false
    
    private var questionsCounterText: String {
        "训练 \(currentQuestion + 1)/\(questions.count) "
    }
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.center) {
            Spacer()
            ZStack {
                HStack {
                    if gameInProgress {
                        Text(questions[currentQuestion].text)
                            .foregroundColor(.orange)
                        Text(answer.isEmpty ? "?" : answer)
                            .foregroundColor(.purple)
                    }
                    else {
                        Text("总分 ")
                            .foregroundColor(.orange)
                        Text("\(score)/\(questions.count)")
                            .foregroundColor(.purple)
                    }
                }
                .font(.system(size: 64))
                
                Image(systemName: "hand.thumbsup")
                    .font(.system(size: 32))
                    .foregroundColor(animatingIncreaseScore ? .green : .clear)
                    .opacity(animatingIncreaseScore ? 0 : 1)
                    .offset(x: 0, y: animatingIncreaseScore ? -100 : -75)
                
                Image(systemName: "hand.thumbsdown")
                    .font(.system(size: 32))
                    .foregroundColor(animatingDecreaseScore ? .red : .clear)
                    .opacity(animatingDecreaseScore ? 0 : 1)
                    .offset(x: 0, y: animatingDecreaseScore ? 100 : 75)
            }
            
            if !gameInProgress {
                NewGameButton(settingsToggle: settingsToggle)
                    .font(.title)
                    .padding()
            }
            
            Spacer()
            
            KeyboardView() { action in
                self.keyboardTapped(action: action)
            }
            .frame(height: 250)
        }
        .onAppear(perform: generateQuestions)
        .navigationBarItems(
            leading: Group {
                if gameInProgress { NewGameButton(settingsToggle: settingsToggle) }
                else { Spacer() }
            },
            trailing: Text(gameInProgress ? questionsCounterText : "")
        )
    }
    
    func generateQuestions() {
        questions = Questions(table: settings.tablesUpTo, numberOfQuestions: settings.numberOfQuestions).questions
        currentQuestion = 0
        gameInProgress = true
    }
    
    func keyboardTapped(action: KeyboardActions) {
        guard gameInProgress else { return }
        
        animatingIncreaseScore = false
        animatingDecreaseScore = false
        
        switch(action) {
        case .k0, .k1, .k2, .k3, .k4, .k5, .k6, .k7, .k8, .k9:
            if answer.count < 3 {
                answer += String(action.rawValue)
            }
        case .delete:
            if answer.count > 0 {
                answer.removeLast()
            }
        case .submit:
            guard !answer.isEmpty else { return }
            
            if questions[currentQuestion].result == answer {
                score += 1
                
                withAnimation(Animation.linear(duration: 1)) {
                    animatingIncreaseScore = true
                }
            }
            else {
                withAnimation(Animation.linear(duration: 1)) {
                    animatingDecreaseScore = true
                }
            }
            
            answer = ""
            
            if currentQuestion >= questions.count - 1 {
                gameInProgress = false
            }
            
            currentQuestion += 1
        default:
            break
        }
    }
}

struct NewGameButton: View {
    @ObservedObject var settingsToggle: SettingsToggle
    
    var body: some View {
        Button("新训练") {
            self.settingsToggle.isSettingsDisplayed.toggle()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(settings: Settings(), settingsToggle: SettingsToggle())
            .colorScheme(.dark)
    }
}
