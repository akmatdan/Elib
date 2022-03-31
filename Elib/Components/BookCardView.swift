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
    
    var animation: Namespace.ID
    
    @EnvironmentObject var sharedData: SharedDataModel
    
    
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
                        
                        VStack(spacing: 5) {
                            
                            // Adding Matched Geometry Effect
                            ZStack {
                                if sharedData.showDetailBook {
                                    HomeImageLoader(url: books.imageName)
                                } else {
                                    HomeImageLoader(url: books.imageName)
                                        .matchedGeometryEffect(id: "\(books.id)IMAGE", in: animation)
                                }
                            }
                            
                            Text(books.title)
                                .font(.custom(customFont, size: 14))
                                .fontWeight(.semibold)
                                .lineLimit(2)
                                .padding(.horizontal, 10)
                                .frame(width: 160)
                            
                            Text(books.author)
                                .font(.custom(customFont, size: 12))
                                .lineLimit(2)
                                .padding(.horizontal, 10)
                                .padding(.bottom, 5)
                        }
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                sharedData.detailBook = books
                                sharedData.showDetailBook = true
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
            
            Text("Popular books")
                .font(.custom(customFont, size: 20))
                .fontWeight(.semibold)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal,10)
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    ForEach(model.books, id: \.self) { books in
                        VStack(spacing: 5) {
                            HomeImageLoader(url: books.imageName)
                            
                            Text(books.title)
                                .font(.custom(customFont, size: 14))
                                .fontWeight(.semibold)
                                .lineLimit(3)
                                .padding(.horizontal, 10)
                                .frame(width: 160)
                            
                            Text(books.author)
                                .font(.custom(customFont, size: 12))
                                .lineLimit(2)
                                .padding(.horizontal, 10)
                                .padding(.bottom, 5)
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
        }
        .background(Color(.systemGray6))
    }
}

struct BookCardView_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
