//
//  MyLibraryView.swift
//  Elib
//
//  Created by Daniil Akmatov on 5/3/22.
//

import SwiftUI

struct MyLibraryView: View {
    var body: some View {
        NavigationView {
            ScrollView{
                Text("MyLibraryView")
            }
        }
        .background(Color(.systemGray6))
    }
}

struct MyLibraryView_Previews: PreviewProvider {
    static var previews: some View {
        MyLibraryView()
    }
}