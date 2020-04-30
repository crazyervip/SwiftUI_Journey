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