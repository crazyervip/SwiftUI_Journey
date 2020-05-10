//
//  ProspectsView.swift
//  22_Project16_HotProspects
//
//  Created by Jacob Zhang on 2020/5/10.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import CodeScanner
import SwiftUI
import UserNotifications

enum FilterType {
    case none, contacted, uncontacted
}

// Challenge 3
enum SortType {
    case name, recent
}

struct ProspectsView: View {
    @EnvironmentObject var prospects: Prospects

    @State private var isShowingScanner = false

    let filter: FilterType

    // Challenge 3
    @State private var isShowingSortOptions = false
    @State var sort: SortType = .name

    var title: String {
        switch filter {
        case .none:
            return "所有人"
        case .contacted:
            return "已联系"
        case .uncontacted:
            return "未联系"
        }
    }

    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }

    // Challenge 3
    var filteredSortedProspects: [Prospect] {
        switch sort {
        case .name:
            return filteredProspects.sorted { $0.name < $1.name }
        case .recent:
            return filteredProspects.sorted { $0.date > $1.date }
        }
    }

    let random = ["Jacob_d\nzjc8966@me.com"]

    var body: some View {
        NavigationView {
            List {
                // Challenge 3
                ForEach(filteredSortedProspects) { prospect in
                    HStack {
                        // Challenge 1
                        if self.filter == .none {
                            Image(systemName: prospect.isContacted ? "envelope.fill" : "envelope.badge")
                        }
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                    }
                    .contextMenu {
                        Button(prospect.isContacted ? "标记为未联系" : "标记为已联系") {
                            self.prospects.toggle(prospect)
                        }
                        if !prospect.isContacted {
                            Button("提醒我") {
                                self.addNotification(for: prospect)
                            }
                        }
                    }
                }.onDelete { offsets in
                    var prospects = [Prospect]()
                    for offset in offsets {
                        prospects.append(self.filteredSortedProspects[offset])
                    }
                    self.prospects.remove(prospects: prospects)
                }
                }
        
            .sheet(isPresented: $isShowingScanner, content: {
                CodeScannerView(codeTypes: [.qr], simulatedData: self.random.randomElement()!, completion: self.handleScan)
            })
            // Challenge 3
            .actionSheet(isPresented: $isShowingSortOptions) {
                ActionSheet(title: Text("排序根据"), buttons: [
                    .default(Text((self.sort == .name ? "✓ " : "") + "姓名"), action: { self.sort = .name }),
                    .default(Text((self.sort == .recent ? "✓ " : "") + "最近"), action: { self.sort = .recent }),
                    .cancel()
                ])
            }
            .navigationBarTitle(title)
            // Challenge 3
                .navigationBarItems(leading: Button(action: {
                    self.isShowingSortOptions = true
                }) {
                    Image(systemName: "arrow.up.arrow.down")
                    Text(getSortString())
                    }
                    , trailing: Button(action: {
                    self.isShowingScanner = true
                }) {
                    Image(systemName: "qrcode.viewfinder")
                    Text("扫码")
                }
            )
        }
    }
    
    func getSortString() -> String {
        var sortString = ""
        if sort == .name {
            sortString = "姓名"
        } else if sort == .recent {
            sortString = "最近"
        }
        return sortString
    }

    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false

        switch result {
            
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }

            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]

            self.prospects.add(person)

        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }

    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "联系人：\(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default

//            var dateComponents = DateComponents()
//            // 将会在 9am 推送提醒
//            dateComponents.hour = 9
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

            // 测试设置为 5 秒后推送
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }

        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            }
            else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    }
                    else {
                        print("Notifications not authorized")
                    }
                }
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedRootView()
    }
}
