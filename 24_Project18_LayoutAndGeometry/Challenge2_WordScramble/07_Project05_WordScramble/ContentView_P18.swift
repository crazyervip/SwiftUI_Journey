//
//  ContentView.swift
//  07_Project05_WordScramble
//
//  Created by Jacob Zhang on 2020/5/8.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI
import Introspect

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var showingKeyboard = true
    
    //MARK: challenge 1
    private let minWordLength = 3
    
    //MARK: challenge 3
    private var score: Int {
        var count = 0
        for word in usedWords {
            count += word.count
        }
        return count
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                //MARK: dark mode
                //                Color("Background").edgesIgnoringSafeArea(.all)
                VStack {
                    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)),Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))]), startPoint: .bottomTrailing, endPoint: .topLeading)
                        .opacity(0.3)
                        .edgesIgnoringSafeArea(.all)
                        .frame(height: 80)
                    Spacer()
                }
                VStack(spacing: 0) {
                    HStack {
                        HStack {
                            Image(systemName: "square.and.pencil")
                                .font(.system(size: 18, weight: .semibold))
                                .padding(Edge.Set.leading, 7)
                                .foregroundColor(Color(.systemPurple))
                            
                            TextField("这些字母打乱顺序还能组成什么？", text: $newWord, onCommit: addNewWord)
                                .introspectTextField { tf in
                                    tf.becomeFirstResponder()
                            }
                            .foregroundColor(.primary)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            
                            
                            Button(action: {
                                self.newWord = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                            }.accentColor(Color(.systemPurple))
                        }
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: 4, trailing: 8))
                            
                            //MARK: 注意 cornerRadius 只能修饰背景，否则会阻止键盘 becomeFirstResponder
                            .background(Color(.systemGray6).opacity(0.8).cornerRadius(20))
                        
                    }
                    .padding()
                    
                    // Project 18 - Challenge 2
                    GeometryReader { listProxy in
                        List(self.usedWords, id: \.self) { word in
                            // Fixing Project 5 for accessibility
                            GeometryReader { itemProxy in
                                HStack {
                                    Image(systemName: "\(word.count).circle")
                                    Text(word)
                                }
                                .accessibilityElement(children: .ignore)
                                .accessibility(label: Text("\(word), \(word.count) letters"))
                                .frame(width: itemProxy.size.width, alignment: .leading)
                                .offset(x: self.getOffset(listProxy: listProxy, itemProxy: itemProxy), y: 0)
                            }
                        }
                            // MARK: 滑动隐藏键盘
                            .gesture(
                                DragGesture()
                                    .onChanged {_ in
                                        self.endEditing()
                                }
                        )
                            .overlay(
                                VStack {
                                    Text("注意每个字母只能用一次")
                                        .foregroundColor(Color(.systemGray))
                                        .padding()
                                        .background(BlurBg(style: .systemUltraThinMaterial))
                                        .cornerRadius(20)
                                        .padding()
                                        .offset(x: self.score > 0 ? 400 : 0)
                                    Spacer()
                                }.animation(.spring())
                        )
                    }
                    
                }
                .edgesIgnoringSafeArea(.bottom)
                .navigationBarTitle(rootWord)
                    // challenge 2
                    .navigationBarItems(leading: Button("换个单词") { self.startGame() }                                .foregroundColor(Color(.systemPurple))
                        , trailing:
                        //MARK: challenge 3
                        Text("总分: \(score)")
                            .font(.system(size: 20, weight: .black, design: .rounded)))
                    .onAppear(perform: startGame)
                    .alert(isPresented: $showingError) {
                        Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("好的")))
                }
            }
        }
    }
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
    
    // Project 18 - Challenge 2
    func getOffset(listProxy: GeometryProxy, itemProxy: GeometryProxy) -> CGFloat {
        let listHeight = listProxy.size.height
        let listStart = listProxy.frame(in: .global).minY
        let itemStart = itemProxy.frame(in: .global).minY
        
        let itemPercent =  (itemStart - listStart) / listHeight * 100
        
        let thresholdPercent: CGFloat = 5
        let indent: CGFloat = 2
        
        if itemPercent > thresholdPercent {
            return (itemPercent - (thresholdPercent - 1)) * indent
        }
        
        return 0
    }
    
    
    func startGame() {
        //MARK: challenge 2
        usedWords.removeAll()
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                
                rootWord = allWords.randomElement() ?? "silkworm"
                
                return
            }
        }
        
        fatalError("无法在 bundle 中找到文件.")
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "这个单词已经想到过了", message: "再好好想想吧")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "范围之外", message: "请使用标题的字母")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "没有这个单词", message: "别瞎编哦")
            return
        }
        
        //MARK: challenge 1
        guard isLongEnough(word: answer) else {
            wordError(title: "该单词太短了", message: "要求至少含有 \(minWordLength) 个字母")
            return
        }
        
        //MARK: challenge 1
        guard isNotWordToGuess(word: answer) else {
            wordError(title: "标题不算", message: "再好好想想吧")
            return
        }
        
        // 顶部插入新 cell
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord.lowercased()
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            }
            else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSMakeRange(0, word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    //MARK: challenge 1
    func isLongEnough(word: String) -> Bool {
        return word.count >= minWordLength
    }
    
    //MARK: challenge 1
    func isNotWordToGuess(word: String) -> Bool {
        return word != rootWord
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        //         .colorScheme(.dark)
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

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
