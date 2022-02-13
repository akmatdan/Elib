//
//  BooksViewModel.swift
//  Elib
//
//  Created by Daniil Akmatov on 10/2/22.
//

import Foundation
import FirebaseFirestore

class BooksViewModel: ObservableObject {
    
    @Published var books = [Book]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        db.collection("books").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.books = documents.map { (querySnapshot) -> Book in
                let data = querySnapshot.data()
                
                let isbn = data["isbn"] as? String ?? ""
                let title = data["title"] as? String ?? ""
                let author = data["author"] as? String ?? ""
                let year = data["year"] as? Int ?? 0
                let description = data["description"] as? String ?? ""
                let imageName = data["imageName"] as? String ?? ""
                
                return Book(isbn: isbn, imageName: imageName, title: title, author: author, year: year, description: description)
            }
        }
    }
}
