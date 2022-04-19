//
//  BookCardview.swift
//  Elib
//
//  Created by Daniil Akmatov on 18/3/22.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseStorage

struct BookCardView: View {
    
    @State var searchText = ""
    @ObservedObject var model = BooksViewModel()
    
    var body: some View {
        ScrollView {
            Text("New books")
                .font(.custom(customFont, size: 20))
                .fontWeight(.semibold)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal,10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(model.books, id: \.self) { books in
                        NavigationLink(destination: BookDetailView(book: books)) {
                            VStack(spacing: 5) {
                                
                                LoadImage(url: "\(books.url)")
                                    
                                Text(books.title)
                                    .font(.custom(customFont, size: 14))
                                    .fontWeight(.semibold)
                                    .lineLimit(2)
                                    .padding(.horizontal, 10)
                                    .frame(width: 160)
                                    .foregroundColor(Color.black)
                                
                                Text(books.author)
                                    .font(.custom(customFont, size: 12))
                                    .lineLimit(2)
                                    .padding(.horizontal, 10)
                                    .padding(.bottom, 5)
                                    .foregroundColor(Color.black)
                            }
                        }
                    }
                    .frame(width: 180, height: 250)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 3, x: 3, y: 3)
                        .padding(5)
                }
                .onAppear() {
                    self.model.fetchData()
                }
            }
            
            Divider()
                .padding()
        }
        .background(Color(.systemGray6))
    }
}

struct BookCardView_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
