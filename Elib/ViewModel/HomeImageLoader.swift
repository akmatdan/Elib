//
//  HomeImageLoader.swift
//  Elib
//
//  Created by Daniil Akmatov on 18/3/22.
//


import SwiftUI
import SDWebImageSwiftUI
import Firebase
import FirebaseStorage

struct HomeImageLoader: View {
    
    @State var url = ""
    
    var body: some View {
        VStack {
            if url != "" {
                AnimatedImage(url: URL(string: url)!)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 190)
                    .cornerRadius(10)
                    .padding()
            } else {
                Loader()
            }
        }
        .onAppear() {
            let storage = Storage.storage().reference()
            storage.child("\(url)").downloadURL { url, err in
                
                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                }
                self.url = "\(url!)"
            }
        }
    }
}
