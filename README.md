
# SwiftUI 项目由浅入深

> 记录学习 [Paul Hudson (Hacking with Swift) 的 *100 days of SwiftUI*](https://www.hackingwithswift.com/100/swiftui) 并融入一些**自己的见解和改善**
> 
> 欢迎关注我的 GitHub: [no-more-coding](https://github.com/no-more-coding)
> 
> - [SwiftUI_Intuition_Library](https://github.com/no-more-coding/SwiftUI_Intuition_Library)：SwiftUI 所有组件 📖 的视觉化演示 🤹🏻 (Control, Layout, Paints, Other) & Modifiers (Controls, Effect, Layout, Text, Image, List, Navigation Bar, Style, Modifiers, Events, Gestures…
> - [SwiftUI_Intuition](https://github.com/no-more-coding/SwiftUI_Intuition) : 基于 [SwiftUI_Intuition_Library](https://github.com/no-more-coding/SwiftUI_Intuition_Library) 的展示app，UI 灵感来源 [*Unsplsh*](https://unsplash.com/)，*App Store*，*快捷指令*
> 
> - [SwiftUI_Journey](https://github.com/no-more-coding/SwiftUI_Journey)：记录学习 [Paul Hudson (Hacking with Swift) 的 *100 days of SwiftUI*](https://www.hackingwithswift.com/100/swiftui) 

## 🧑🏻‍💻进度

种类               | 情况 
:---               |  :---:  
Projects | 3 / 19 
Challenges | 9 / 57 
Milestone Projects | 0 / 6
Challenge days     |  1 / 1
Improvements | 🔷 13 

## 预览

### P1_AA 收款

 项目需求                                                     |                            图例1                             |                            图例2                             
 :----------------------------------------------------------- | :----------------------------------------------------------: | :----------------------------------------------------------: 
 <br/>>1. Add a header to the third section, saying “Amount per person”.<br/><br/>>2. Add another section showing the total amount for the check<br/> – i.e., the original amount plus tip value, without dividing by the number of people.<br/>>3. Change the “Number of people” picker to be a text field, making sure to use the correct keyboard type.<br/> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/01_Project01_WeSplit/screenshots/screen01.png" alt="2020-04-28 16.22.23" style="zoom:35%;" /> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/01_Project01_WeSplit/screenshots/screen02.png" alt="2020-04-28 16.22.23" style="zoom:35%;" /> 

#### 🏷️标签：Form, Section, NavigationView, @State property wrapper, TextField, Picker, ForEach, Stepper, UITextField, UIApplication, TextField 配合 Stepper

📢完整代码请查看 *[ContentView](https://github.com/no-more-coding/SwiftUI_Journey/blob/master/01_Project01_WeSplit/P1_WeSplit/ContentView.swift)*

实现 | 改进               | 图例 
:---               | :---               |  :---:
**`Form`, <br/>`Section`, <br/>`NavigationView`, <br/>`TextField`** | **🔷为数字键盘加上 `完成` 按钮^1⃣️^** <br/>○  `extension UITextField`<br/>○  `introspectTextField`<br/><br/>**🔷通过上滑和下滑隐藏键盘^2⃣️^**<br/>○  `extension UIApplication`<br/>○  `DragGesture()` | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/01_Project01_WeSplit/screenshots/2020-04-28 16.22.23.gif" alt="2020-04-28 16.22.23" style="zoom:35%;" /> 
**`Segment Control`<br/>`ForEach`^3⃣️^ **, <br/>**`@State`** ^4⃣️^, <br/>`$` 符号^5⃣️^ |**🔷`Stepper`^6⃣️^** | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/01_Project01_WeSplit/screenshots/2020-04-28 16.16.49.gif" alt="2020-04-28 16.22.23" style="zoom:35%;" /> 
**显示 `Double` 两位小数 ^7⃣️^** | **🔷`TextField`配合`Stepper` ^8⃣️^ ** | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/01_Project01_WeSplit/screenshots/2020-04-28 16.19.24.gif" style="zoom:35%;" /> 

1⃣️ & 5⃣️

`$` 提供同一个 `Struct` 内部的双向绑定（two-way binding）, 此处 `checkAmount` 可随用户输入更新

``` swift
						TextField("输入金额", text: $checkAmount)
                            //  完成按钮使用方法
                            .introspectTextField { textField in
                                textField.addDoneCancelToolbar()
                        }
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

// 添加完成按钮
extension UITextField {
    func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
        //    let onCancel = onCancel ?? (target: self, action: #selector(tapCancel))
        let onDone = onDone ?? (target: self, action: #selector(tapDone))
        
        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            //        UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "完成", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()
        
        self.inputAccessoryView = toolbar
    }
    @objc func tapDone() {
        print("tapped Done")
        self.resignFirstResponder()
    }
    @objc func tapCancel() {
        print("tapped cancel")
        self.resignFirstResponder()
    }
}
```

2⃣️

``` swift
            // 滑动隐藏键盘
			.gesture(
                DragGesture()
                    .onChanged {_ in
                        self.endEditing()
                }
            )
            
    private func endEditing() {
        UIApplication.shared.endEditing()
    }

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
```

3⃣️

``` swift
				Section(header: Text("要付多少比例的小费?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
```

4⃣️

- `@` 是一种属性包装器 (Property Wrapper)
- 使用 `@State` 的 `var` 可时刻监听 `body` 中对应值的变化并随之变化（mutating）

6⃣️ & 8⃣️

- 使用在 `TextField` 中的 `var` 一般是 `String` 类型
- `Int` 类型需在 TF 里改 `text ：`为 `value: ` 
- 并添加 `formatter: NumberFormatter()` 
- ⚠️ : 如果为 Int 则不会随输入自动更新，需按下**回车键** <br/>

``` swift
						TextField("包括自己", value: $numberOfPeople, formatter: NumberFormatter())
                        .keyboardType(.numbersAndPunctuation)
                        .disableAutocorrection(true)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        Stepper("", value: $numberOfPeople, in: 1...1000).labelsHidden()
```

7⃣️

``` swift
Text("\(totalPerPerson, specifier: "%.2f") 元")`
```

#### 📎附：键盘类型

![](https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/01_Project01_WeSplit/keyboardType1.png)

![](https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/01_Project01_WeSplit/keyboardType2.png)

### C1_单位换算器

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

#### 🏷️标签：Form, Section, NavigationView, @State property wrapper, TextField, Picker, ForEach, UIApplication, protocol, static, UnitLength, UnitDuration, UnitVolume, UnitTemperature, Dimension, enum, converted

📢完整代码请查看 *[ContentView](https://github.com/no-more-coding/SwiftUI_Journey/blob/master/02_ChallengeDay01_Converter/02_ChallengeDay01_Converter/ContentView.swift)*

实现 | 改进               | 图例 
:---               | :---               |  :---:
**[`Form`, <br/>`Section`, <br/>`NavigationView`, <br/>`TextField`,<br/>`Segment Control`<br/>&`ForEach` , <br/>`@State` , <br/>`$` 符号^P1^](https://blog.csdn.net/qq_41239137/article/details/105827493),<br/><br/>[`protocol`, <br/>`static`, <br/>`UnitLength`, <br/>`UnitDuration`, <br/>`UnitVolume`,<br/>`UnitTemperature`, <br/>`Dimension`, <br/>`enum`, <br/>`converted`^见Modal^](https://github.com/no-more-coding/SwiftUI_Journey/tree/master/02_ChallengeDay01_Converter/02_ChallengeDay01_Converter/Model)** | **🔷通过上滑和下滑隐藏键盘[^P1^]()**<br/>○  `extension UIApplication`<br/>○  `DragGesture()`<br/><br/>**🔷换算符号优化^1⃣️^**<br/>○  `SF Symbol`<br/><br/>**设置显示小数最多为5位 <br/>且为 0 时省略^2⃣️^**<br/> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/02_ChallengeDay01_Converter/screenshots/2020-04-29 16.30.02.gif" alt="2020-04-28 16.22.23" style="zoom:35%;" /> 

1⃣️

``` swift
				Section(header: HStack {
                    Spacer()
                    Image(systemName: "arrow.up.arrow.down.circle.fill")
                        .font(.title)
                        .padding(.bottom, 20)
                    Spacer()
                })
```

2⃣️

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

 项目需求                                                     |                            图例1                             |                            图例2                             
 :----------------------------------------------------------- | :----------------------------------------------------------: | :----------------------------------------------------------: 
 <br/>>1. Add an @State property to store the user’s score, modify it when they get an answer right or wrong, then display it in the alert.<br/><br/>>2. Show the player’s current score in a label directly below the flags.<br/><br/>>3. When someone chooses the wrong flag, tell them their mistake in your alert message<br/> – something like “Wrong! That’s the flag of France,” for example.<br/> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/03_Project02_GuessTheFlag/screenshots/screen01.png" style="zoom:35%;" /> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/03_Project02_GuessTheFlag/screenshots/screen02.png"  style="zoom:35%;" /> 

#### 🏷️标签：ZStack, VStack, Image, Alert, SPAlert, Haptic, LinearGradient, Spacer, shuffled, random, renderingMode, overlay, Capsule, stroke, UIViewRepresentable

📢完整代码请查看 *[ContentView](https://github.com/no-more-coding/SwiftUI_Journey/blob/master/03_Project02_GuessTheFlag/03_Project02_Guess%20the%20Flag/ContentView.swift)*

实现 | 改进               | 图例 
:---               | :---               |  :---:
**`ZStack`, <br/>`VStack`, <br/>`Image`, <br/>`Alert`,<br/>`SPAlert`,<br/>`haptic` , <br/>`LinearGradient`,<br/>`Spacer()`, <br/>`shuffled`, <br/>`random`, <br/>`renderingMode`^3⃣️^, <br/>`overlay`,<br/>`Capsule`, <br/>`UIViewRepresentable`,<br/>`stroke`** | **🔷`SPAlert`^1⃣️^** <br/>**🔷*总分* 模糊背景^2⃣️^** | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/03_Project02_GuessTheFlag/screenshots/2020-04-29 22.05.24.gif" alt="2020-04-28 16.22.23" style="zoom:35%;" /> 

在 [SwiftUI_Intuition_Library](https://github.com/no-more-coding/SwiftUI_Intuition_Library) 里发现更多关于 [overlay](https://github.com/no-more-coding/SwiftUI_Intuition_Library/blob/master/Markdowns/modifier_Mask.md)，[stroke](https://github.com/no-more-coding/SwiftUI_Intuition_Library/blob/master/Markdowns/modifier_Border.md)，[Alert](https://github.com/no-more-coding/SwiftUI_Intuition_Library/blob/master/Markdowns/modifier_Alert.md)等内容

1⃣️

``` swift
// SPAlert
            let alertView = SPAlertView(title: "正确", message: "得分+1", preset: SPAlertPreset.done)
            alertView.duration = 1
            alertView.haptic = .success
            alertView.present()
```

2⃣️

``` swift
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

3⃣️ 

``` swift
Image(self.countries[number])
//使图片在 Botton 和 NavigationLink 正常显示
	.renderingMode(.original)
```

#### 📎附：Text 类型

![](https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/03_Project02_GuessTheFlag/text1.png)

![](https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/03_Project02_GuessTheFlag/text2.png)

### P3_Views 和 Modifiers

 项目需求                                                     |                             图例                             
 :----------------------------------------------------------- | :----------------------------------------------------------: 
 <br/>>1. Create a custom ViewModifier (and accompanying View extension) that makes a view have a large, blue font suitable for prominent titles in a view.<br/> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/04_Project03_ViewsAndModifiers/screenshots/screen01.png" alt="2020-04-28 16.22.23" style="zoom:35%;" /> 
 <br/>>2. Go back to project 1 and use a conditional modifier to change the total amount text view to red if the user selects a 0% tip.<br/> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/04_Project03_ViewsAndModifiers/Challenge2/screenshots/screen01.png" alt="2020-04-28 16.22.23" style="zoom:35%;" /> 
 <br/>>3. Go back to project 2 and create a FlagImage() view that renders one flag image using the specific set of modifiers we had.<br/> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/04_Project03_ViewsAndModifiers/Challenge3/screenshots/screen01.png" alt="2020-04-28 16.22.23" style="zoom:35%;" /> 


#### 🏷️标签：Views, Modifiers

------

📢完整代码请查看 *[SwiftUI_Journey](https://github.com/no-more-coding/SwiftUI_Journey)*

实现 | 改进               | 图例 
:---               | :---               |  :---:
**`struct LargeTitle: ViewModifier {...}`, <br/>`extension View {...}` <br/><br/>`struct Challenge1: View {...    .largeTitle()}`^1⃣️^ ** |  | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/04_Project03_ViewsAndModifiers/screenshots/1.gif" alt="2020-04-28 16.22.23" style="zoom:35%;" /> 
**`a ? b : c`^2⃣️^**<br/>  ○ a 为真，则使用 b 的值，反之，c 的值 | | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/04_Project03_ViewsAndModifiers/screenshots/2.gif" alt="2020-04-28 16.22.23" style="zoom:35%;" /> 
** `Extract SubView`  ^3⃣️^** |  | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/04_Project03_ViewsAndModifiers/screenshots/3.gif" style="zoom:35%;" /> 

1⃣️ 

``` swift
// challenge 1
struct LargeTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.orange)
            .padding()
            .background(BlurBg(style: .systemUltraThinMaterial))
            .clipShape(Capsule())
            .shadow(radius: 5, x: 0, y: 5)
    }
}

// challenge 1
extension View {
    func largeTitle() -> some View {
        self.modifier(LargeTitle())
    }
}

struct Challenge1: View {
    var body: some View {
        Text("自定义的 ViewModifier")
            .largeTitle()
    }
}
```

2⃣️ 

``` swift
					Text("\(grandTotal, specifier: "%.2f") 元")
                        // MARK: Project03_challenge2
                        .foregroundColor(self.tipPercentages[self.tipPercentage] == 0 ? Color.red : Color.primary)
```

3⃣️

<center> from <center>

``` swift
						Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
```

<center> to <center>

``` swift
//MARK: Project03_Challenge3
Flag(name: self.countries[number])

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
```

#### 💬拓展：

------

##### 1 Modifiers 的顺序

``` swift
struct ModifiersOrder: View {
    var body: some View {
        VStack {
            Spacer()

            Button("Hello World") {
                print(type(of: self.body))
            }
            .frame(width: 200, height: 200)
            .background(Color.red)

            Spacer()

            Text("Hello World")
            .padding()
            .background(Color.red)
            .padding()
            .background(Color.blue)
            .padding()
            .background(Color.green)
            .padding()
            .background(Color.yellow)

            Spacer()
        }
    }
}
```

<details open>
  <summary></summary>
  <p align="center">
  <img width="35%" src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/04_Project03_ViewsAndModifiers/screenshots/4.gif"/>
</details>

##### 2 一个 modifier 作用于多个 Views

``` swift
struct EnvironmentModifiers: View {
    var body: some View {
        VStack {
            Spacer()
            EnvironmentModifier()
            Spacer()
            RegularModifier()
            Spacer()
        }
    }
}

struct EnvironmentModifier: View {
    var body: some View {
        VStack {
            Text("SwiftUI 项目")
                .font(.largeTitle) //  重写字体，显示为 largeTitle
            Text("由浅入深")
        }
        .font(.title) // 全部显示为 title
    }
}

struct RegularModifier: View {
    var body: some View {
        VStack {
            VStack {
                Text("SwiftUI 项目")
                    .blur(radius: 7) // 重写模糊，显示为 .blur(radius: 10) ,最低为 3，使用 -3 无法取消模糊
                Text("由浅入深")
            }
            .blur(radius: 3) // 全部显示为 .blur(radius: 3)
            .font(.title)
        }
    }
}
```

<details open>
  <summary></summary>
  <p align="center">
  <img width="35%" src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/04_Project03_ViewsAndModifiers/screenshots/5.gif"/>
</details>

#####  3 Modifiers 也适用于 Text 等类型

``` swift
struct PropertyViews: View {
    let text1 = Text("SwiftUI 项目")
    let text2 = Text("由浅入深")

    // 或者
    //var text1: some View { Text("SwiftUI 项目") }
    //var text2: some View { Text("由浅入深") }

    var body: some View {
        VStack {
            text1
                .foregroundColor(.red)
            text2
                .foregroundColor(.blue)
        }
    }
}
```

<details open>
  <summary></summary>
  <p align="center">
  <img width="35%" src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/04_Project03_ViewsAndModifiers/screenshots/6.gif"/>
</details>

##### 4 Modifiers 也适用于 View 类型

``` swift
struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

struct ViewComposition: View {
    var body: some View {
        VStack(spacing: 10) {
            CapsuleText(text: "SwiftUI 项目")
                .foregroundColor(.white)
            CapsuleText(text: "由浅入深")
                .foregroundColor(.yellow)
        }
    }
}
```

<details open>
  <summary></summary>
  <p align="center">
  <img width="35%" src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/04_Project03_ViewsAndModifiers/screenshots/7.gif"/>
</details>

##### 5 自定义的 Modifiers

``` swift
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}

struct CustomModifiers: View {
    var body: some View {
        VStack {
            Spacer()

            Text("Hello World!")
                .titleStyle()

            Spacer()

            Color.blue
            .frame(width: 300, height: 200)
            .watermarked(with: "SwiftUI 项目由浅入深")

            Spacer()
        }
    }
}
```

<details open>
  <summary></summary>
  <p align="center">
  <img width="35%" src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/04_Project03_ViewsAndModifiers/screenshots/8.gif"/>
</details>

##### 6 组合成 格子视图

``` swift
struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let spacing: CGFloat
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack(spacing: spacing) {
            ForEach(0 ..< rows) { row in
                HStack (spacing: self.spacing) {
                    ForEach(0 ..< self.columns) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
    
    init(rows: Int, columns: Int, spacing: CGFloat, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.spacing = spacing
        self.content = content
    }
}

struct CustomContainers: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(0 ..< 5) { item in
                        Section (header: HStack {
                            Text("Section \(item+1)")
                                .padding(.horizontal)
                            Spacer()
                        }) {
                            GridStack(rows: 3, columns: 3, spacing: 5) { row, col in
                                Rectangle()
                                    .foregroundColor(Color.clear)
                                    .frame(minWidth: UIScreen.main.bounds.width/3)
                                    .frame(minHeight: UIScreen.main.bounds.width/3)
                                    .background(Color.orange.opacity(0.2))
                                    .background(VStack {
                                        Image(systemName: "\(row * 3 + col+1).circle")
                                        Text("R\(row+1) C\(col+1)")
                                    }.font(.system(size: 18, weight: .semibold))
                                        .padding()
                                        .background(Color.red.opacity(0.3))
                                )
                            }
                        }
                    }
                }
            }.navigationBarTitle("Grid View")
        }
    }
}
```
iPhone 8               | iPhone 11   
 :---:                |  :---:  
<img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/04_Project03_ViewsAndModifiers/screenshots/10.gif" style="zoom:33%;" /> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/04_Project03_ViewsAndModifiers/screenshots/9.gif" style="zoom:33%;" />