//
//  BookListView.swift
//  Elib
//
//  Created by Daniil Akmatov on 7/2/22.
//

import SwiftUI
import FirebaseAuth

struct MyLibraryView: View {
    
    @State var searchText = ""
    @ObservedObject var model = BooksViewModel()
    
    @State var showDeleteOption: Bool = false
    
    // Geting userID for adding data to myLibrary page
    let userID = Auth.auth().currentUser?.uid
    
    var body: some View {
        NavigationView {
            VStack() {
                Text("My Library")
                    .font(.custom(customFont, size: 28).bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 22)
                    
                SearchBar(searchText: $searchText)
                
                    if let filteredBooks = filteredBooks {
                        List{
                            ForEach(filteredBooks, id: \.self) { books in
                                if userID == books.uid {
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
                                            print("Deleted")
                                            model.deleteData(bookToDelete: filteredBooks[0])
                                        } label: {
                                            Label("Delete", systemImage: "trash.circle.fill")
                                        }
                                        
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

