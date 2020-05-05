//
//  DetailView.swift
//  14_Project11_Bookworm
//
//  Created by Jacob Zhang on 2020/5/3.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import CoreData
import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode

    @State private var showingDeleteAlert = false

    let book: Book

    // challenge 1
    var genreName: String {
        guard let genre = book.genre else { return "未知" }
        guard !genre.isEmpty else { return "未知" }

        return genre
    }

    // challenge 3
    var formattedDate: String {
        guard let date = book.date else { return "" }
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return "\(formatter.string(from: date)) 添加评论"
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    // challenge 1
                    Image(self.genreName)
                        .frame(maxWidth: geometry.size.width)

                    // challenge 1
                    Text(self.genreName.uppercased())
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }

                Text(self.book.author ?? "未知作者")
                    .font(.title)
                    .foregroundColor(.secondary)

                Text(self.book.review ?? "暂无评论")
                    .padding()

                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)

                Spacer()

                // challenge 3
                Text(self.formattedDate)
                    .padding()
            }
        }
        .navigationBarTitle(Text(book.title ?? "未知标题"), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            self.showingDeleteAlert = true
        }) {
            Image(systemName: "trash")
        })
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("删除此书"),
                  message: Text("确定吗？"),
                  primaryButton: .destructive(Text("删除")) { self.deleteBook() },
                  secondaryButton: .cancel()
            )
        }
    }

    func deleteBook() {
        moc.delete(book)

        presentationMode.wrappedValue.dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    static var previews: some View {
        let book = Book(context: moc)
        book.title = "测试标题"
        book.author = "测试作者"
        book.genre = "奇幻"
        book.rating = 4
        book.review = "真香"

        return NavigationView {
            DetailView(book: book)
        }
//        .colorScheme(.dark)
    }
}
