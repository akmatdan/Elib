//
//  BookCardview.swift
//  Elib
//
//  Created by Daniil Akmatov on 18/3/22.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseStorage
import FirebaseAuth

struct BookCardView: View {
    
    @State var searchText = ""
    @ObservedObject var model = BooksViewModel()
    
    // Geting userID for adding data to myLibrary page
    let userID = Auth.auth().currentUser?.uid
    
    var body: some View {
        
        var items: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
        ScrollView {
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack {
                    LazyVGrid(columns: items, spacing: 10) {
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
                    
                }
                .padding(.top, 10)
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
