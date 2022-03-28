//
//  BookDetailView.swift
//  Elib
//
//  Created by Daniil Akmatov on 9/2/22.
//

import SwiftUI

struct BookDetailView: View {
    var book: Book
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero
    
    @ObservedObject var model = BooksViewModel()
    
    var body: some View {

        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    DetailImageLoader(url: book.imageName)

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

                        Text("ISBN: \(book.isbn)")
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }
                    VStack {
                        Divider()
                        
                        Text("Description:")
                            .font(.title3)
                            .foregroundColor(.secondary)
                        
                        ScrollView {
                            Text(book.description)
                                .font(.body)
                                .padding(.horizontal)
                        }
                        .frame(width: 400, height: 200)
                    }
                    Spacer()
                }
            }
        }.hiddenNavigationBarStyle()
    }
}
