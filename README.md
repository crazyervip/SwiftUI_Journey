
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
Projects | 6 / 19 
Challenges | 18 / 57 
Milestone Projects | 2 / 6 
Challenge days     |  1 / 1
Improvements | 🔷 17 

## 01_P1_AA 收款

 项目要点                                                     |                            图例1                             |                            图例2                             
 :----------------------------------------------------------- | :----------------------------------------------------------: | :----------------------------------------------------------: 
 <br/>>1. Add a header to the third section, saying “Amount per person”.<br/><br/>>2. Add another section showing the total amount for the check<br/> – i.e., the original amount plus tip value, without dividing by the number of people.<br/>>3. Change the “Number of people” picker to be a text field, making sure to use the correct keyboard type.<br/> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/01_Project01_WeSplit/screenshots/screen01.png"  style="zoom:100%;" /> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/01_Project01_WeSplit/screenshots/screen02.png"  style="zoom:100%;" /> 

### 🏷️标签：

#### Form, Section, NavigationView, @State property wrapper, TextField, Picker, ForEach, Stepper, UITextField, UIApplication, TextField 配合 Stepper

📢完整代码请查看 *[SwiftUI_Journey](https://github.com/no-more-coding/SwiftUI_Journey)*


实现 | 改进               | 图例 
:---               | :---               |  :---:
**`Form`, `Section`, `NavigationView`, `TextField`** | **🔷为数字键盘加上 `完成` 按钮^1⃣️^** <br/>○  `extension UITextField`<br/>○  `introspectTextField`<br/><br/>**🔷通过上滑和下滑隐藏键盘^2⃣️^**<br/>○  `extension UIApplication`<br/>○  `DragGesture()` | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/01_Project01_WeSplit/screenshots/2020-04-28 16.22.23.gif"  style="zoom:100%;" /> 
**`Segment Control``ForEach`^3⃣️^ **, **`@State`** ^4⃣️^, `$` 符号^5⃣️^ |**🔷`Stepper`^6⃣️^** | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/01_Project01_WeSplit/screenshots/2020-04-28 16.16.49.gif"  style="zoom:100%;" /> 
**显示 `Double` 两位小数 ^7⃣️^** | **🔷`TextField`配合`Stepper` ^8⃣️^ ** | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/01_Project01_WeSplit/screenshots/2020-04-28 16.19.24.gif" style="zoom:100%;" /> 

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
- ⚠️ : 如果为 Int 则不会随输入自动更新，需按下**回车键** 

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

### 📎附：键盘类型

![](https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/01_Project01_WeSplit/keyboardType1.png)

![](https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/01_Project01_WeSplit/keyboardType2.png)



## 02_C1_单位换算器

 项目要点                                                     |                            图例1                             |                            图例2                             
 :----------------------------------------------------------- | :----------------------------------------------------------: | :----------------------------------------------------------: 
 <br/>**You need to build an app that handles unit conversions**: <br/><br/>users will select an input unit and an output unit, then enter a value,and see the output of the conversion.<br/> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/02_ChallengeDay01_Converter/screenshots/screen01.png"  style="zoom:100%;" /> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/02_ChallengeDay01_Converter/screenshots/screen02.png"  style="zoom:100%;" /> 

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

### 🏷️标签：

#### Form, Section, NavigationView, @State property wrapper, TextField, Picker, ForEach, UIApplication, protocol, static, UnitLength, UnitDuration, UnitVolume, UnitTemperature, Dimension, enum, converted

📢完整代码请查看 *[SwiftUI_Journey](https://github.com/no-more-coding/SwiftUI_Journey)*


实现 | 改进               | 图例 
:---               | :---               |  :---:
**[`Form`, `Section`, `NavigationView`, `TextField`,`Segment Control`<br/>&`ForEach` , `@State` , `$` 符号^P1^](),<br/><br/>[`protocol`, `static`, `UnitLength`, <br/>`UnitDuration`, `UnitVolume`,<br/>`UnitTemperature`, `Dimension`, <br/>`enum`, `converted`^见Modal^](https://github.com/no-more-coding/SwiftUI_Journey/tree/master/02_ChallengeDay01_Converter/02_ChallengeDay01_Converter/Model)** | **🔷通过上滑和下滑隐藏键盘[^P1^]()**<br/>○  `extension UIApplication`<br/>○  `DragGesture()`<br/><br/>**🔷换算符号优化^1⃣️^**<br/>○  `SF Symbol`<br/><br/>**设置显示小数最多为5位 且为 0 时省略^2⃣️^**<br/> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/02_ChallengeDay01_Converter/screenshots/2020-04-29 16.30.02.gif"  style="zoom:100%;" /> 

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



## 03_P2_猜国旗

 项目要点                                                     |                            图例1                             |                            图例2                             
 :----------------------------------------------------------- | :----------------------------------------------------------: | :----------------------------------------------------------: 
 <br/>>1. Add an @State property to store the user’s score, modify it when they get an answer right or wrong, then display it in the alert.<br/><br/>>2. Show the player’s current score in a label directly below the flags.<br/><br/>>3. When someone chooses the wrong flag, tell them their mistake in your alert message<br/> – something like “Wrong! That’s the flag of France,” for example.<br/> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/03_Project02_GuessTheFlag/screenshots/screen01.png" style="zoom:100%;" /> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/03_Project02_GuessTheFlag/screenshots/screen02.png"  style="zoom:100%;" /> 

### 🏷️标签：

#### ZStack, VStack, Image, Alert, SPAlert, Haptic, LinearGradient, Spacer, shuffled, random, renderingMode, overlay, Capsule, stroke, UIViewRepresentable

📢完整代码请查看 *[SwiftUI_Journey](https://github.com/no-more-coding/SwiftUI_Journey)*


实现 | 改进               | 图例 
:---               | :---               |  :---:
**`ZStack`, `VStack`, `Image`, `Alert`,`SPAlert`,`haptic` , `LinearGradient`,<br/>`Spacer()`, `shuffled`, `random`, `renderingMode`^3⃣️^, <br/>`overlay`,`Capsule`, `UIViewRepresentable`,`stroke`** | **🔷`SPAlert`^1⃣️^** <br/>**🔷*总分* 模糊背景^2⃣️^**<br/>**🔷选项移至下方，用户更易触及** | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/03_Project02_GuessTheFlag/screenshots/2020-04-29 22.05.24.gif"  style="zoom:100%;" /> 

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

### 📎附：Text 类型

![](https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/03_Project02_GuessTheFlag/text1.png)

![](https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/03_Project02_GuessTheFlag/text2.png)



## 04_P3_Views 和 Modifiers

 项目要点                                                     |                             图例                             
 :----------------------------------------------------------- | :----------------------------------------------------------: 
 <br/>>1. Create a custom ViewModifier (and accompanying View extension) that makes a view have a large, blue font suitable for prominent titles in a view.<br/> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/04_Project03_ViewsAndModifiers/screenshots/screen01.png"  style="zoom:100%;" /> 
 <br/>>2. Go back to project 1 and use a conditional modifier to change the total amount text view to red if the user selects a 0% tip.<br/> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/04_Project03_ViewsAndModifiers/Challenge2/screenshots/screen01.png"  style="zoom:100%;" /> 
 <br/>>3. Go back to project 2 and create a FlagImage() view that renders one flag image using the specific set of modifiers we had.<br/> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/04_Project03_ViewsAndModifiers/Challenge3/screenshots/screen01.png"  style="zoom:100%;" /> 

### 🏷️标签：

#### Views, Modifiers, Modifiers 的顺序, 一个 modifier 作用于多个 Views, Modifiers 也适用于 Text 等类型, Modifiers 也适用于 View 类型, 自定义的 Modifiers, 组合成格子视图

------

📢完整代码请查看 *[SwiftUI_Journey](https://github.com/no-more-coding/SwiftUI_Journey)*

实现 |                图例 
:---                             |  :---:
**`struct LargeTitle: ViewModifier {...}`, `extension View {...}` `struct Challenge1: View {...    .largeTitle()}`^1⃣️^ ** |   <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/04_Project03_ViewsAndModifiers/screenshots/1.gif"  style="zoom:100%;" /> 
**`a ? b : c`^2⃣️^**<br/>  ○ 三元运算符<br/>  ○ a 为真，则使用 b 的值，反之，c 的值 |  <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/04_Project03_ViewsAndModifiers/screenshots/2.gif"  style="zoom:100%;" /> 
** `Extract SubView`  ^3⃣️^** |   <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/04_Project03_ViewsAndModifiers/screenshots/3.gif" style="zoom:100%;" /> 

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

<center> from </center>

``` swift
						Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
```

<center> to </center>

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

### 💬拓展：

------

#### 1 Modifiers 的顺序

```swift
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

#### 2 一个 modifier 作用于多个 Views

```swift
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

####  3 Modifiers 也适用于 Text 等类型

```swift
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

#### 4 Modifiers 也适用于 View 类型

```swift
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

#### 5 自定义的 Modifiers

```swift
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

#### 6 🔷组合成格子视图

```swift
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



## 05_M1(1-3)_石头剪刀布

 项目要点                                                     |                             图例                             
 :----------------------------------------------------------- | :----------------------------------------------------------: 
 <br/>>- *Each turn of the game the app will randomly pick either rock, paper, or scissors.*<br/>\>- *Each turn the app will either prompt the player to win or lose.*<br/>\>- *The player must then tap the correct move to win or lose the game.*<br/> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/05_Milestone01(1-3)_RockPaperScissors/screenshots/screen01.png"  style="zoom:100%;" /> 
 <br/>\>- *If they are correct theyscore a point; otherwise they lose a point.*<br/>\>- *The game ends after 10 questions, at which point their score is shown.*<br/>\>- *So, if the app chose “Rock” and “Win” the player would need to choose “Paper”, but if the app chose “Rock” and “Lose” the player would need to choose “Scissors”.*<br/> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/05_Milestone01(1-3)_RockPaperScissors/screenshots/screen02.png"  style="zoom:100%;" /> 

### 🏷️标签：

#### ObservableObject, Timer, switch, case, onReceive

------

📢完整代码请查看 *[SwiftUI_Journey](https://github.com/no-more-coding/SwiftUI_Journey)*

实现 | 改进               | 图例 
:---               | :---               |  :---:
**`Timer`, `switch`, `case`,`onReceive`** | **🔷视图优化** <br/>**🔷添加[`ObservableObject`](https://github.com/no-more-coding/SwiftUI_Journey/tree/master/05_Milestone01(1-3)_RockPaperScissors/ObservableObject_Version) 版本** | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/05_Milestone01(1-3)_RockPaperScissors/screenshots/1.gif"  style="zoom:100%;" /> 

## 06_P4_好睡眠

 项目要点                                                     |                             图例                             
 :----------------------------------------------------------- | :----------------------------------------------------------: 
 <br/>\>1. *Replace each VStack in our form with a Section, where the text view is the title of the section. Do you prefer this layout or the VStack layout? It’s your app – you choose!*<br/><br/>\>2. *Replace the “Number of cups” stepper with a Picker showing the same range of values.*<br/><br/>\>3. *Change the user interface so that it always shows their recommended bedtime using a nice and large font. You should be able to remove the “Calculate” button entirely.*<br/> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/06_Project04_BetterRest/screenshots/screen01.png" style="zoom:150%;" /> 

### 🏷️标签：

#### Machine Learning, Dates (DatePicker, DateComponents, DateFormatter) Stepper

📢完整代码请查看 *[SwiftUI_Journey](https://github.com/no-more-coding/SwiftUI_Journey)*


实现               | 图例 
:---                             |  :---:
**`Create ML`, `DatePicker`, `DateComponents`, `DateFormatter`**  | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/06_Project04_BetterRest/screenshots/1.gif"  style="zoom:50%;" /> 

自动控制小数点

``` swift
//MARK: challenge 1
                Section(header: Text("你想睡多久？").font(.headline)) {
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        //MARK: 自动控制小数点
                        Text("\(sleepAmount, specifier: "%g") 小时")
                    }
                }
```

## 07_P5_猜单词

 项目要点                                                     |                             图例                             
 :----------------------------------------------------------- | :----------------------------------------------------------: 
 <br/>\>1. *Disallow answers that are shorter than three letters or are just our start word. For the three-letter check, the easiest thing to do is put a check into isReal() that returns false if the word length is under three letters. For the second part, just compare the start word against their input word and return false if they are the same.*<br/><br/>\>2. *Add a left bar button item that calls startGame(), so users can restart with a new word whenever they want to.*<br/><br/>\>3. *Put a text view below the List so you can track and show the player’s score for a given root word. How you calculate score is down to you, but something involving number of words and their letter count would be reasonable.*<br/> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/07_Project05_WordScramble/screenshots/screen01.png" style="zoom:100%;" /> 

### 🏷️标签：

#### List, onAppear, Bundle, fatalError(), UITextChecker, navigationBarItems, becomeFirstResponder

📢完整代码请查看 *[SwiftUI_Journey](https://github.com/no-more-coding/SwiftUI_Journey)*


实现               | 图例1 | 图例2
:---                             |  :---: |  :---:
**`.introspectTextField{}`, <br/>🔷`becomeFirstResponder`,<br/> `List`, `onAppear`, <br/>`Bundle`, `fatalError()`,<br/> `UITextChecker`, <br/>🔷`navigationBarItems`(避免键盘遮挡)**  | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/07_Project05_WordScramble/screenshots/1.gif"  style="zoom:50%;" /> |<img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/07_Project05_WordScramble/screenshots/3.gif"  style="zoom:50%;" />
<img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/07_Project05_WordScramble/screenshots/4.gif"  style="zoom:50%;" />  | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/07_Project05_WordScramble/screenshots/5.gif"  style="zoom:50%;" /> |<img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/07_Project05_WordScramble/screenshots/2.gif"  style="zoom:50%;" />
<img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/07_Project05_WordScramble/screenshots/6.gif"  style="zoom:50%;" />  | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/07_Project05_WordScramble/screenshots/7.gif"  style="zoom:50%;" /> |

## 08_P6_Animations 和 Transitions

 项目要点                                                     |                             图例                             
 :----------------------------------------------------------- | :----------------------------------------------------------: 
 <br/>\>1. *When you tap the correct flag, make it spin around 360 degrees on the Y axis.*<br/><br/>\>2. *Make the other two buttons fade out to 25% opacity.*<br/><br/>\>3. *And if you tap on the wrong flag? Well, that’s down to you – get creative!*<br/> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/08_Project06_Animations/Challenges/screenshots/screen01.png" style="zoom:100%;" /> 

### 🏷️标签：

#### animations, transitions, rotation3DEffect, scaleEffect, 三元运算符的嵌套, 抖动效果, DragGesture

📢完整代码请查看 *[SwiftUI_Journey](https://github.com/no-more-coding/SwiftUI_Journey)*


实现               | 图例 
:---                             |  :---:
**`rotation3DEffect`,  🔷三元运算符的嵌套^1⃣️^ `a ? b : (c ? d : e)`,  🔷`scaleEffect` ,🔷抖动效果^2⃣️^**  | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/08_Project06_Animations/screenshots/1.gif"  style="zoom:50%;" /> 
**`.DragGesture()`**,**`.translation`**,  | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/08_Project06_Animations/screenshots/2.gif"  style="zoom:50%;" /> 

1⃣️

``` swift
.foregroundColor(animatingIncreaseScore ? .green : (animatingDecreaseScore ? .red : .white))
.background(animatingDecreaseScore ? Color.red.opacity(0.8) : (animatingIncreaseScore ? Color.green.opacity(0.8) : nil))
```

2⃣️

``` swift
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
```

## 09_M2(4-6)_乘法表试炼

 项目要点                                                     |                             图例                             
 :----------------------------------------------------------- | :----------------------------------------------------------: 
 <br/>\>- *The player needs to select which multiplication tables they want to practice. This could be pressing buttons, or it could be an “Up to…” stepper, going from 1 to 12.*<br/>\>- *The player should be able to select how many questions they want to be asked: 5, 10, 20, or “All”.*<br/>\>- *You should randomly generate as many questions as they asked for, within the difficulty range they asked for. For the “all” case you should generate all possible combinations.*<br/> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/09_Milestone02(4-6)_MultiplicationTables/screenshots/screen01.png"  style="zoom:100%;" /> 
 <br/>\>*If you want to go fully down the “education” route then this is going to be some steppers, a text field and a couple of buttons. I would suggest that’s a good place to start, just to make sure you have the basics covered.*<br/>\>*Once you have that, it’s down to you how far you want to take the app down the “entertainment” route – you could throw away fixed controls like Stepper entirely if you wanted, and instead rely on colorful buttons to get the same result. You could use something like Kenney’s Animal Pack (which is public domain, by the way!) to add a fun theme to make it into a real game. And hopefully you will also add some over the top animations – it needs to appeal to kids 9 and under, so going bright, colorful, and perhaps even a bit zany is a good idea!*<br/> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/09_Milestone02(4-6)_MultiplicationTables/screenshots/screen02.png"  style="zoom:100%;" /> 

### 🏷️标签：

#### 自定义数字键盘, ObservableObject, Published, ObservedObject, 

------

📢完整代码请查看 *[SwiftUI_Journey](https://github.com/no-more-coding/SwiftUI_Journey)*

实现 |  图例1 |  图例2 
:---               |  :---: |  :---:
**`Timer`, `switch`, `case`,`onReceive`, `Timer`, `switch`, `case`,`onReceive`** | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/09_Milestone02(4-6)_MultiplicationTables/screenshots/1.gif"  style="zoom:100%;" /> | <img src="https://no-more-coding.coding.net/p/SwiftUI-Journey/d/SwiftUI-Journey/git/raw/master/09_Milestone02(4-6)_MultiplicationTables/screenshots/2.gif"  style="zoom:100%;" /> 


