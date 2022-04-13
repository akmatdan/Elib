//
//  ProfileView.swift
//  Elib
//
//  Created by Daniil Akmatov on 5/3/22.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView {
            NavigationView {
                VStack {
                    Text("MyLibrary")
                }
                .navigationTitle("MyLibrary")
            }
        }
        .background(Color(.systemGray6))
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
