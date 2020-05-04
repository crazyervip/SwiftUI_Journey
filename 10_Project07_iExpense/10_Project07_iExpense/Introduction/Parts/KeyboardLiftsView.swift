//
//  KeyboardLiftsView.swift
//  10_Project07_iExpense
//
//  Created by Jacob Zhang on 2020/5/3.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct KeyboardLiftsView: ViewModifier {
  @State var currentHeight: CGFloat = 0

  func body(content: Content) -> some View {
    content
      .padding(.bottom, currentHeight)
      .edgesIgnoringSafeArea(.bottom)
      .onAppear(perform: subscribeToKeyboardEvents)
    .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
  }

  private func subscribeToKeyboardEvents() {
    NotificationCenter.Publisher(
      center: NotificationCenter.default,
      name: UIResponder.keyboardWillShowNotification
    ).compactMap { notification in
        notification.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect
    }.map { rect in
        
// 可增加弹起高度。 0至TextField处
        
      rect.height + 50
    }.subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))

    NotificationCenter.Publisher(
      center: NotificationCenter.default,
      name: UIResponder.keyboardWillHideNotification
    ).compactMap { notification in
      CGFloat.zero
    }.subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))
  }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

