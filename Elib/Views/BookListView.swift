//
//  BookListView.swift
//  Elib
//
//  Created by Daniil Akmatov on 7/2/22.
//

import SwiftUI

struct BookListView: View {
    
    var books: [Book] = BookList.topTen
    
    @State var searchText = ""
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            SearchBar(searchText: $searchText)
            
            List(filteredBooks, id: \.id) { books in
                
                HStack() {
                    Image(books.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 120)
                        .cornerRadius(5)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        
                        Text(books.title)
                            .fontWeight(.semibold)
                            .lineLimit(2)
                            .minimumScaleFactor(0.5)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        Text(books.author)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Image(systemName: "heart")
                            .frame(width: 20, height: 30)
                        
                        Image(systemName: "chevron.down")
                    }
                }
                .padding(.vertical, 8)
            }
            .padding(.horizontal, -15)
            .searchable(text: $searchText)
        }
    }
    
    var filteredBooks: [Book] {
        if searchText.isEmpty {
            return books
        } else {
            return books.filter { ($0.title.localizedCaseInsensitiveContains(searchText)) ||
                ($0.author.localizedCaseInsensitiveContains(searchText))
            }
        }
    }
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView()
    }
}


