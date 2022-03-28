//
//  HistoryList.swift
//  Elib
//
//  Created by Daniil Akmatov on 18/3/22.
//

import SwiftUI

struct LibrariesList: View {
    var body: some View {
        NavigationView {
            ZStack {
                Text("LibrarisList")
                Spacer()
            }
        }
        .background(Color(.systemGray6))
    }
}

struct LibrariesList_Previews: PreviewProvider {
    static var previews: some View {
        LibrariesList()
    }
}
