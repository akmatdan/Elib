//
//  Books.swift
//  Elib
//
//  Created by Daniil Akmatov on 7/2/22.


import Foundation

struct Books: Identifiable, Hashable {
    var id = UUID()
    var isbn: String
    var imageName: String
    var title: String
    var author: String
    var year: Int
    let description: String
}

//struct BookList {
//    static let topTen = [
//        Book(isbn: "12345", imageName: "image1", title: "The Adventure of Tom Sawyer + The Adventures of Huckleberry Finn", author: "Mark Twain", year: 1867, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus maximus neque eu viverra facilisis. Morbi sodales orci erat, a luctus erat luctus et. Donec accumsan tortor id erat elementum, sit amet rhoncus nibh pellentesque."),
//        Book(isbn: "22345", imageName: "image2", title: "A Tale of Two Cities", author: "Charles Dickens", year: 1999, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus maximus neque eu viverra facilisis. Morbi sodales orci erat, a luctus erat luctus et. Donec accumsan tortor id erat elementum, sit amet rhoncus nibh pellentesque."),
//        Book(isbn: "32345", imageName: "image3", title: "Sense and Sensibility", author: "Jane Austen", year: 1999, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus maximus neque eu viverra facilisis. Morbi sodales orci erat, a luctus erat luctus et. Donec accumsan tortor id erat elementum, sit amet rhoncus nibh pellentesque."),
//    ]
//}
