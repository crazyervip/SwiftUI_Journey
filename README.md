
# SwiftUI 项目由浅入深

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
Projects | 2 / 19 
Challenges | 6 / 57 
Milestone Projects | 0 / 6
Challenge days     |  1 / 1
Improvements | 🔷 6

## 预览

### P1_AA 收款

#### Form, Section, NavigationView, @State property wrapper, TextField, Picker, ForEach

 项目需求                                                     |                            图例1                             |                            图例2                             
 :----------------------------------------------------------- | :----------------------------------------------------------: | :----------------------------------------------------------: 
 <br/>>1. Add a header to the third section, saying “Amount per person”.<br/><br/>>2. Add another section showing the total amount for the check<br/> – i.e., the original amount plus tip value, without dividing by the number of people.<br/>>3. Change the “Number of people” picker to be a text field, making sure to use the correct keyboard type.<br/> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/01_Project01_WeSplit/screenshots/screen01.png" alt="2020-04-28 16.22.23" style="zoom:35%;" /> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/01_Project01_WeSplit/screenshots/screen02.png" alt="2020-04-28 16.22.23" style="zoom:35%;" /> 

#### Stepper, UITextField, UIApplication, TextField 配合 Stepper

我的实现 & 改进               | 图例 
:---               |  :---:
**🔷为数字键盘加上 `完成` 按钮** <br/>○  `extension UITextField`<br/>○  `introspectTextField`<br/><br/>**🔷通过上滑和下滑隐藏键盘**<br/>○  `extension UIApplication`<br/>○  `DragGesture()`<br/> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/01_Project01_WeSplit/screenshots/2020-04-28 16.22.23.gif" alt="2020-04-28 16.22.23" style="zoom:35%;" /> 
**`Stepper`, `Segment Control` 的使用** <br/><br/>**`@State`**的使用<br/>○  `@` 是一种属性包装器 (Property Wrapper)<br/>○  使用 `@State` 的 `var` 可时刻监听 `body` 中对应值的变化并随之变化（mutating）<br/> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/01_Project01_WeSplit/screenshots/2020-04-28 16.16.49.gif" alt="2020-04-28 16.22.23" style="zoom:35%;" /> 
**🔷`TextField`配合`Stepper`**  <br/>○  使用在 `TextField` 中的 `var` 一般是 `String` 类型<br/>○  `Int` 类型需在 TF 里改 `text ：`为 `value: ` <br/>○  并添加 `formatter: NumberFormatter()` <br/>○  ⚠️ : 如果为 Int 则不会随输入自动更新，需按下**回车键** <br/><br/>**显示 `Double` 两位小数的方法**<br/>○  `Text("\(totalPerPerson, specifier: "%.2f") 元")`<br/><br/> **`??`空合运算符**<br/>○  `let orderAmount = Double(checkAmount) ?? 0`<br/>○  如果 `Double(checkAmount)` 为空，则使用默认使用 `0`<br/> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/01_Project01_WeSplit/screenshots/2020-04-28 16.19.24.gif" style="zoom:35%;" /> 

#### 附：键盘类型

![](https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/01_Project01_WeSplit/keyboardType1.png)

![](https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/01_Project01_WeSplit/keyboardType2.png)

### C1_单位换算器

#### Form, Section, NavigationView, @State property wrapper, TextField, Picker, ForEach

 项目需求                                                     |                            图例1                             |                            图例2                             
 :----------------------------------------------------------- | :----------------------------------------------------------: | :----------------------------------------------------------: 
 <br/>**You need to build an app that handles unit conversions**: <br/><br/>users will select an input unit and an output unit, then enter a value,and see the output of the conversion.<br/> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/02_ChallengeDay01_Converter/screenshots/screen01.png" alt="2020-04-28 16.22.23" style="zoom:35%;" /> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/02_ChallengeDay01_Converter/screenshots/screen02.png" alt="2020-04-28 16.22.23" style="zoom:35%;" /> 

>Which units you choose are down to you, but you could choose one of these:
>- Temperature conversion: users choose Celsius, Fahrenheit, or Kelvin.
>- Length conversion: users choose meters, kilometers, feet, yards, or miles.
>- Time conversion: users choose seconds, minutes, hours, or days.
>- Volume conversion: users choose milliliters, liters, cups, pints, or gallons.
>
>If you were going for length conversion you might have:
>- A segmented control for meters, kilometers, feet, yard, or miles, for the input unit.
>- A second segmented control for meters, kilometers, feet, yard, or miles, for the output unit.
>- A text field where users enter a number.
>- A text view showing the result of the conversion.
>
>So, if you chose meters for source unit and feet for output unit, then entered 10, you’d see 32.81 as the output.
>
>If you want a bigger challenge, try adding a third segmented control that lets us change the unit being converted – give your program the ability to convert temperature, length, time, or volume, all in one app.

#### UIApplication, protocol, static, UnitLength, UnitDuration, UnitVolume, UnitTemperature, Dimension, **enum**, converted

我的实现 & 改进               | 图例 
:---               |  :---:
**设置显示小数最多为5位** <br/>且为零时省略<br/>○  `见底部 代码块`<br/><br/>**🔷通过上滑和下滑隐藏键盘**<br/>○  `extension UIApplication`<br/>○  `DragGesture()`<br/><br/>**🔷换算符号优化**<br/>○  `SF Symbol`<br/> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/02_ChallengeDay01_Converter/screenshots/2020-04-29 16.30.02.gif" alt="2020-04-28 16.22.23" style="zoom:35%;" /> 


``` swift
// 设置显示小数最多为5位
    func format(number: Double) -> String {
        // 比 %.5f specifier 方法好，因为可以自动去掉为 0 的小数
        let formatter = NumberFormatter()
        let nsnumber = NSNumber(value: number)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 5
        return String(formatter.string(from: nsnumber) ?? "")
    }
```

### P2_猜国旗

#### ZStack, VStack, Image, Alert

 项目需求                                                     |                            图例1                             |                            图例2                             
 :----------------------------------------------------------- | :----------------------------------------------------------: | :----------------------------------------------------------: 
 <br/>>1. Add an @State property to store the user’s score, modify it when they get an answer right or wrong, then display it in the alert.<br/><br/>>2. Show the player’s current score in a label directly below the flags.<br/><br/>>3. When someone chooses the wrong flag, tell them their mistake in your alert message<br/> – something like “Wrong! That’s the flag of France,” for example.<br/> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/03_Project02_GuessTheFlag/screenshots/screen01.png" style="zoom:35%;" /> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/03_Project02_GuessTheFlag/screenshots/screen02.png"  style="zoom:35%;" /> 

#### SPAlert, Haptic, LinearGradient, Spacer, shuffled, random, renderingMode, overlay, Capsule, stroke, UIViewRepresentable

我的实现 & 改进               | 图例 
:---               |  :---:
**🔷 `SPAlert`** <br/>○  `见底部 代码块`<br/><br/>**🔷模糊背景**<br/>○  `见底部 代码块`<br/> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/03_Project02_GuessTheFlag/screenshots/2020-04-29 22.05.24.gif" alt="2020-04-28 16.22.23" style="zoom:35%;" /> 

``` swift
// SPAlert
            let alertView = SPAlertView(title: "正确", message: "得分+1", preset: SPAlertPreset.done)
            alertView.duration = 1
            alertView.haptic = .success
            alertView.present()

//MARK: 模糊背景

.background(BlurBg(style: .systemUltraThinMaterial))

struct BlurBg: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
```

#### 附：Text 类型

![](https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/03_Project02_GuessTheFlag/text1.png)

![](https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/03_Project02_GuessTheFlag/text2.png)
