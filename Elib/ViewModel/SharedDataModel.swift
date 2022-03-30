//
//  SharedData.swift
//  Elib
//
//  Created by Daniil Akmatov on 30/3/22.
//

import SwiftUI

class SharedDataModel: ObservableObject {
    
    // Detail books data:
    @Published var detailBook: Book?
    @Published var showDetailBook: Bool = false
    
}

