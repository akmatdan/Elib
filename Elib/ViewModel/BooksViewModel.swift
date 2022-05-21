//
//  BooksViewModel.swift
//  Elib
//
//  Created by Daniil Akmatov on 10/2/22.


import Foundation
import FirebaseFirestore
import FirebaseAuth

class BooksViewModel: ObservableObject {

    @Published var books = [Book]()
    
    func deleteBook(with id: String) {
        let db = Firestore.firestore()
        db.collection("books").whereField("id", isEqualTo: id).getDocuments { (snap, err) in
            
            if err != nil {
                print("Error")
                return
            }
            
            for i in snap!.documents {
                DispatchQueue.main.async {
                    i.reference.delete()
                }
            }
        }
        
    }

    func deleteData(bookID: String?) {
        
        // Get ref to the db
        let db = Firestore.firestore()
        
        if let bookToDeleteID = bookID {
            
            // Specify the doc to delete
            db.collection("books").document(bookToDeleteID).delete { error in
                
                // Check for errors
                if error == nil {
                    
                    // Update UI from the main thread
                    DispatchQueue.main.async {
                        
                        // Remove the book that was just deleted
                        self.books.removeAll { books in
                            
                            // Check for the book to remove
                            return books.id == bookToDeleteID
                        }
                    }
                } else {
                    print(error!.localizedDescription)
                }
            }
        }
        
    }
    
    
//    func addData(isbn: String, title: String, author: String, year: String, description: String, url: String) {
//        
//        // Get ref to the db
//        let db = Firestore.firestore()
//        db.collection("books").addDocument(data: ["isbn": isbn, "title": title, "author": author, "year": year, "description": description, url: "url"]) { error in
//            
//            if error == nil {
//                
//                // Call data to retrive latest data
//                self.fetchData()
//            } else {
//                print((error?.localizedDescription)!)
//                return
//            }
//        }
//        
//        // Add data to collection
//    }

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
                                         title: d["title"] as? String ?? "",
                                         author: d["author"] as? String ?? "",
                                         year: d["year"] as? String ?? "",
                                         description: d["description"] as? String ?? "",
                                         url: d["url"] as? String ?? "",
                                         likedBooks: d["liked"] as? Bool ?? false,
                                         uid: d["uid"] as? String ?? ""
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
