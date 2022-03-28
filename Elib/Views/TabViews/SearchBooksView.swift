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
                
                List(filteredBooks, id: \.self) { books in
                    
                    NavigationLink(destination: BookDetailView(book: books)) {
                        HStack() {
                            ImageLoader(url: books.imageName)
                            
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
                            
                            // Deleting button
//                            VStack(alignment: .leading, spacing: 5) {
//                                Button(action: {
//                                    model.deleteData(bookToDelete: books)
//                                }, label: {
//                                    Image(systemName: "minus.circle")
//                                })
//                                Spacer()
//                            }
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

struct SearchBooksView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBooksView()
    }
}


