//
//  SharedDataModel.swift
//  Elib
//
//  Created by Daniil Akmatov on 28/3/22.
//

import Foundation

class SharedDateModel: ObservableObject {
    
    // Detail book data
    @Published var detailBook: Book?
    @Published var showDetailBook: Bool = false
}
