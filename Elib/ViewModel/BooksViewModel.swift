//
//  BooksViewModel.swift
//  Elib
//
//  Created by Daniil Akmatov on 10/2/22.


import Foundation
import FirebaseFirestore

class BooksViewModel: ObservableObject {

    @Published var books = [Book]()
    
    // Detail books data:
    @Published var detailBook: Book?
    @Published var showDetailBook: Bool = false

    func deleteData(bookToDelete: Book) {
        
        // Get ref to the db
        let db = Firestore.firestore()
        
        // Specify the doc to delete
        db.collection("books").document(bookToDelete.id).delete { error in
            
            // Check for errors
            if error == nil {
                
                // Update UI from the main thread
                DispatchQueue.main.async {
                    
                    // Remove the book that was just deleted
                    self.books.removeAll { book in
                        
                        // Check for the book to remove
                        return book.id == bookToDelete.id
                    }
                }
            }
        }
    }
    
    func addData(isbn: String, title: String, author: String, year: String, description: String) {
        
        // Get ref to the db
        let db = Firestore.firestore()
        db.collection("books").addDocument(data: ["isbn": isbn, "title": title, "author": author, "year": year, "description": description]) { error in
            
            if error == nil {
                
                // Call data to retrive latest data
                self.fetchData()
            } else {
                print((error?.localizedDescription)!)
                return
            }
        }
        
        // Add data to collection
    }

    func fetchData() {
        let db = Firestore.firestore()

        db.collection("books").getDocuments { snapshot, error in
            if error == nil {

                if let snapshot = snapshot {

                    DispatchQueue.main.async {
                        // Get all the documents and create books
                        self.books = snapshot.documents.map { d in
                            
                            // Create a book item for each document returned
                            return Book(
                                         isbn: d["isbn"] as? String ?? "",
                                         imageName: d["imageName"] as? String ?? "",
                                         title: d["title"] as? String ?? "",
                                         author: d["author"] as? String ?? "",
                                         year: d["year"] as? String ?? "",
                                         description: d["description"] as? String ?? ""
                            )
                        }
                    }
                }
            } else {
                print((error?.localizedDescription)!)
                return
            }
        }
    }
}
