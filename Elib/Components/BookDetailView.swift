//
//  BookDetailView.swift
//  Elib
//
//  Created by Daniil Akmatov on 9/2/22.
//

import SwiftUI

struct BookDetailView: View {
    
    // For Matched Geometry Effect
    var animation: Namespace.ID
    
    var book: Book
    
    // Shared Data
    @EnvironmentObject var sharedData: SharedDataModel
    
    var body: some View {
        VStack {
            
            // Title Bar and book Imge
            VStack {
                
                // Title Bar
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(Color.black.opacity(0.7))
                    }
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "heart")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .foregroundColor(Color.black.opacity(0.7))
                    }
                }
                .padding()
                
                // Book Image
                // Adding Matched Geometry Effect
                DetailImageLoader(url: book.imageName)
                    .matchedGeometryEffect(id: "\(book.id)IMAGE", in: animation)
            }
            .frame(height: getRect().height / 2.7)
            .padding(.top, 15)
            
            // Data of book
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    Text(book.title)
                        .font(.custom(customFont, size: 20).bold())
                    
                    Text(book.author)
                        .font(.custom(customFont, size: 18).bold())
                        .foregroundColor(Color.gray)
                    
                    HStack {
                        Text("Published:")
                            .font(.custom(customFont, size: 18).bold())
                            .foregroundColor(Color.gray)
                        
                        Text(book.year)
                            .font(.custom(customFont, size: 18))
                            .foregroundColor(Color.gray)
                    }
                    
                    HStack {
                        Text("ISBN:")
                            .font(.custom(customFont, size: 18).bold())
                            .foregroundColor(Color.gray)
                        
                        Text(book.isbn)
                            .font(.custom(customFont, size: 18))
                            .foregroundColor(Color.gray)
                    }

                    Text(book.description)
                        .font(.custom(customFont, size: 15).bold())
                        .foregroundColor(Color.gray)
                        .lineLimit(3)
                
                    Button {
                        
                    } label: {
                        Label {
                            Image(systemName: "arrow.right")
                        } icon: {
                            Text("Full desscription")
                        }
                        .font(.custom(customFont, size: 15))
                        .foregroundColor(Color(red: 0.2, green: 0.0, blue: 0.7))
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Add to library")
                            .font(.custom(customFont, size: 20))
                            .foregroundColor(Color.white)
                            .padding(.vertical, 15)
                            .frame(maxWidth: .infinity)
                            .background(
                                Color(red: 0.2, green: 0.0, blue: 0.7)
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                            )
                    }

                }
                .padding([.horizontal,.bottom,], 10)
                .padding(.top, 25)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                    .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
            )
        }.background(Color(.systemGray6))
            .hiddenNavigationBarStyle()
            .navigationBarHidden(true)
    }
}
