//
//  BookListView.swift
//  Elib
//
//  Created by Daniil Akmatov on 7/2/22.
//

import SwiftUI

struct SearchBooksView: View {
    
    @State var searchText = ""
    @ObservedObject var model = BooksViewModel()
    
    var body: some View {
        NavigationView {
            VStack() {
                
                SearchBar(searchText: $searchText)
                
                if searchText != "" {
                    if let filteredBooks = filteredBooks {
                        List(filteredBooks, id: \.self) { books in
                            
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
                        }
                    } else {
                        VStack {
                            Text("Not found!")
                            Spacer()
                        }
                    }
                    
                } else {
                    Text("Try to search books of other libraries!")
                    Spacer()
                }
                
            }
            .background(Color(.systemGray6))
            .onAppear() {
                model.fetchData()
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
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

