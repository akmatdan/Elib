//
//  Books.swift
//  Elib
//
//  Created by Daniil Akmatov on 7/2/22.
//

import Foundation

struct Book: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let author: String
    let description: String
}

struct BookList {
    static let topTen = [
        Book(imageName: "image1", title: "The Adventure of Tom Sawyer + The Adventures of Huckleberry Finn", author: "Mark Twain", description: "..."),
        Book(imageName: "image2", title: "A Tale of Two Cities", author: "Charles Dickens", description: "..."),
        Book(imageName: "image3", title: "Sense and Sensibility", author: "Jane Austen", description: "..."),
    ]
}
