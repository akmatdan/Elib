//
//  BooksViewModel.swift
//  Elib
//
//  Created by Daniil Akmatov on 10/2/22.
//

import Foundation
import FirebaseFirestore

class BooksViewModel: ObservableObject {
    
    @Published var books = [Books]()
    
    func addData() {
        
    }
    
    func fetchData() {
        let db = Firestore.firestore()
        
        db.collection("books").getDocuments { snapshot, error in
            if error == nil {
                
                if let snapshot = snapshot {
                    
                    DispatchQueue.main.async {
                        
                        self.books = snapshot.documents.map { d in
                            return Books(
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
