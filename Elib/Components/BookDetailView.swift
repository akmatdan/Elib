//
//  BookDetailView.swift
//  Elib
//
//  Created by Daniil Akmatov on 9/2/22.
//

import SwiftUI

struct BookDetailView: View {
    
    var book: Book
    
    // For Matched Geometry Effect
    var animation: Namespace.ID
    
    // Shared Data
    @ObservedObject var model = BooksViewModel()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            
            // Title Bar and book Imge
            VStack {
                
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
                    
                    HStack {
                        Text(book.title)
                            .font(.custom(customFont, size: 20).bold())
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: "heart")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 22, height: 22)
                                .foregroundColor(Color.black.opacity(0.7))
                                .padding(.horizontal, 10)
                        }
                    }
                    
                    
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
        }
        .background(Color(.systemGray6))
        .hiddenNavigationBarStyle()
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
    }
    
    var btnBack : some View { Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                Image(systemName: "chevron.left") // set image here
                    .aspectRatio(contentMode: .fit)
                    .font(.title3)
                    .foregroundColor(Color.black.opacity(0.7))
                }
            }
        }
}
