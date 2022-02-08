//
//  BookDetailView.swift
//  Elib
//
//  Created by Daniil Akmatov on 9/2/22.
//

import SwiftUI

struct BookDetailView: View {
    
    var book: Book
    
    var body: some View {
        
        NavigationView {
            
            VStack(spacing: 20) {
                Image(book.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 350)
                    .cornerRadius(12)
                
                Text(book.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                HStack(spacing: 40) {
                    Text("Author: \(book.author)")
                        .font(.title3)
                        .foregroundColor(.secondary)
                    
                    Text("Published: \(book.year)")
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
                
                Text(book.description)
                    .font(.body)
                    .padding()
            }
            .navigationTitle("Details")
        }
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(book: BookList.topTen.first!)
    }
}
