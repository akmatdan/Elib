//
//  Books.swift
//  Elib
//
//  Created by Daniil Akmatov on 7/2/22.


import Foundation

struct Book: Identifiable, Hashable {
    var id = UUID().uuidString
    var isbn: String
    var imageName: String
    var title: String
    var author: String
    var year: String
    let description: String
}
