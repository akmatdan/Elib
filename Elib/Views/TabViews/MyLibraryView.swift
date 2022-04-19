//
//  BookListView.swift
//  Elib
//
//  Created by Daniil Akmatov on 7/2/22.
//

import SwiftUI

struct MyLibraryView: View {
    
    @State var searchText = ""
    @ObservedObject var model = BooksViewModel()
    
    @State var showDeleteOption: Bool = false
    
    var body: some View {
        NavigationView {
//            ScrollView(.vertical, showsIndicators: false) {
//                VStack {
//                    HStack {
//                        Text("Favourites")
//                            .font(.custom(customFont, size: 28).bold())
//
//                        Spacer()
//
//                        Button {
//                            withAnimation {
//                                showDeleteOption.toggle()
//                            }
//                        } label: {
//                            Image(systemName: "trash")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width:25, height: 25)
//                        }
//
//                    }
//                    .padding()
//
//                    if model.books.likedBooks.isEmpty {
//                        Group {
//                            Image("onBoardImage1")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .padding()
//                                .padding(.top, 35)
//                            Text("No favorites yet")
//                                .font(.custom(customFont, size: 25))
//                                .fontWeight(.semibold)
//                        }
//                    } else {
//                        VStack(spacing: 25) {
//                            ForEach(model.books){ product in
//                                HStack(spacing: 0) {
//
//                                    if showDeleteOption{
//                                        Button {
//                                            deleteBook(product: product)
//                                        } label: {
//                                            Image(systemName: "minus.circle.fill")
//                                                .font(.title2)
//                                                .foregroundColor(.red)
//                                        }
//                                        .padding(.trailing)
//                                    }
//                                    CardView(product: product)
//                                }
//                            }
//                        }
//                        .padding(.top, 25)
//                        .padding(.horizontal)
//                    }
//                }
//
//            }
//            .background(Color(.systemGray6))
            
            VStack() {
                SearchBar(searchText: $searchText)
                    if let filteredBooks = filteredBooks {
                        List{
                            ForEach(filteredBooks, id: \.self) { books in
                                
                                NavigationLink(destination: BookDetailView(book: books)) {
                                    HStack() {
                                        SearchLoadImage(url: "\(books.url)")

                                        VStack(alignment: .leading, spacing: 5) {

                                            Text(books.title)
                                                .fontWeight(.semibold)
                                                .lineLimit(2)
                                                .minimumScaleFactor(0.5)
                                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

                                            Text(books.author)
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)

                                            Text(books.isbn)
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                    
                                }
                                .swipeActions {
                                    Button(role: .destructive) {
                                        print("Delete")
                                    } label: {
                                        Label("Delete", systemImage: "trash.circle.fill")
                                    }

                                }
                                
                            }
                        }
                    }
            }
            .background(Color(.systemGray6))
            .onAppear() {
                model.fetchData()
            }
        }.navigationBarHidden(true)
    }
    
    var filteredBooks: [Book] {
        if searchText.isEmpty {
            return model.books
        } else {
            return model.books.filter { ($0.title.localizedCaseInsensitiveContains(searchText)) ||
                ($0.author.localizedCaseInsensitiveContains(searchText)) ||
                ($0.isbn.localizedStandardContains(searchText))
            }
        }
    }
}

