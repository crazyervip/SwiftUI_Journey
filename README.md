
# SwiftUI *项目由浅入深*

> 记录学习 [Paul Hudson (Hacking with Swift) 的 *100 days of SwiftUI*](https://www.hackingwithswift.com/100/swiftui) 并融入一些**自己的见解和改善**
> 
> 欢迎关注我的 GitHub: [no-more-coding](https://github.com/no-more-coding)
> 
> - [SwiftUI_Intuition_Library](https://github.com/no-more-coding/SwiftUI_Intuition_Library)：SwiftUI 所有组件 📖 的视觉化演示 🤹🏻 (Control, Layout, Paints, Other) & Modifiers (Controls, Effect, Layout, Text, Image, List, Navigation Bar, Style, Modifiers, Events, Gestures…
> - [SwiftUI_Intuition](https://github.com/no-more-coding/SwiftUI_Intuition) : 基于 [SwiftUI_Intuition_Library](https://github.com/no-more-coding/SwiftUI_Intuition_Library) 的展示app，UI 灵感来源 [*Unsplsh*](https://unsplash.com/)，*App Store*，*快捷指令*
> 
> - [SwiftUI_Journey](https://github.com/no-more-coding/SwiftUI_Journey)：记录学习 [Paul Hudson (Hacking with Swift) 的 *100 days of SwiftUI*](https://www.hackingwithswift.com/100/swiftui) 

## 进度

种类               | 情况 
:---               |  :---:  
Projects | 1 / 19 
Challenges | 3 / 57 
Milestone Projects | 0 / 6
Improvements | 🔷 3 

## 预览

### P1_AA 收款

#### Form, Section, NavigationView, @State property wrapper, TextField, Picker, ForEach

Paul Hudson (Hacking with Swift)   | 图例1 | 图例2 
:----  |:---:  |  :---:
*100 days of SwiftUI*   |<img src="https://user-gold-cdn.xitu.io/2020/4/28/171c12b8507b203e?w=341&h=677&f=png&s=44662" alt="2020-04-28 16.22.23" style="zoom:35%;" /> | <img src="https://user-gold-cdn.xitu.io/2020/4/28/171c12b89cb13465?w=341&h=677&f=png&s=56383" alt="2020-04-28 16.22.23" style="zoom:35%;" />

#### Stepper, UITextField, UIApplication, TextField 配合 Stepper

笔记               | 图例 
:---               |  :---:
**🔷为数字键盘加上 `完成` 按钮** <br/>○  `extension UITextField`<br/>○  `introspectTextField`<br/><br/>**🔷通过上滑和下滑隐藏键盘**<br/>○  `extension UIApplication`<br/>○  `DragGesture()`<br/> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/01_Project01_WeSplit/screenshots/2020-04-28 16.22.23.gif" alt="2020-04-28 16.22.23" style="zoom:35%;" /> 
**`Stepper`, `Segment Control` 的使用** <br/><br/>**`@State`**的使用<br/>○  `@` 是一种属性包装器 (Property Wrapper)<br/>○  使用 `@State` 的 `var` 可时刻监听 `body` 中对应值的变化并随之变化（mutating）<br/><br/> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/01_Project01_WeSplit/screenshots/2020-04-28 16.16.49.gif" alt="2020-04-28 16.22.23" style="zoom:35%;" /> 
**🔷`TextField`配合`Stepper`**  <br/>○  使用在 `TextField` 中的 `var` 一般是 `String` 类型<br/>○  `Int` 类型需在 TF 里改 `text ：`为 `value: ` <br/>○  并添加 `formatter: NumberFormatter()` <br/>○  ⚠️ : 如果为 Int 则不会随输入自动更新，需按下**回车键** <br/><br/>**显示 `Double` 两位小数点方法**<br/>○  `Text("\(totalPerPerson, specifier: "%.2f") 元")`<br/><br/> **`??`空合运算符**<br/>○  `let orderAmount = Double(checkAmount) ?? 0`<br/>○  如果 `Double(checkAmount)` 为空，则使用默认使用 `0`<br/><br/> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/01_Project01_WeSplit/screenshots/2020-04-28 16.19.24.gif" style="zoom:35%;" /> 

#### 键盘类型

![](https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/01_Project01_WeSplit/keyboardType1.png)

![](https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/01_Project01_WeSplit/keyboardType2.png)

