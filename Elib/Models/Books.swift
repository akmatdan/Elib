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
    var year: String
    let description: String
}
