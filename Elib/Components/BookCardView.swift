//
//  BookCardview.swift
//  Elib
//
//  Created by Daniil Akmatov on 18/3/22.
//

import SwiftUI

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
                        VStack {
                            HomeImageLoader(url: books.imageName)
                            
                            Text(books.title)
                                .font(.custom(customFont, size: 14))
                                .fontWeight(.semibold)
                                .lineLimit(2)
                                .padding(.bottom, 5)
                        }
                    }
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 10)
                }
                .onAppear() {
                    self.model.fetchData()
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        
                    }
                }
            }
            
            Divider()
                .padding()
            
            Text("Popular books")
                .font(.custom(customFont, size: 20))
                .fontWeight(.semibold)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal,10)
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    ForEach(model.books, id: \.self) { books in
                        VStack {
                            HomeImageLoader(url: books.imageName)
                            
                            Text(books.title)
                                .font(.custom(customFont, size: 14))
                                .fontWeight(.semibold)
                                .lineLimit(2)
                                .padding(.bottom, 5)
                        }
                    }
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 10)
                }
                .onAppear() {
                    self.model.fetchData()
                }
            }
        }
        .background(Color(.systemGray6))
    }
}

struct BookCardView_Previews: PreviewProvider {
    static var previews: some View {
        BookCardView()
    }
}
