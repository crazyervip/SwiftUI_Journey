//
//  AddBookView.swift
//  14_Project11_Bookworm
//
//  Created by Jacob Zhang on 2020/5/3.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode

    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
        
    let genres = ["奇幻", "恐怖", "儿童", "神秘", "诗歌", "浪漫", "惊悚","未知"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("书名（必填）", text: $title)
                    TextField("作者", text: $author)

                    Picker("类型", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section {
                    RatingView(rating: $rating)
                    TextField("写书评", text: $review)
                }

                Section {
                    Button("保存") {
                        let newBook = Book(context: self.moc)
                        newBook.title = self.title
                        newBook.author = self.author
                        newBook.rating = Int16(self.rating)
                        newBook.genre = self.genre
                        newBook.review = self.review

                        // challenge 3
                        newBook.date = Date()

                        try? self.moc.save()

                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(title == "" ? true : false)
                }
            }
            .navigationBarTitle("添加书籍")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
