//
//  DetailImageLoader.swift
//  Elib
//
//  Created by Daniil Akmatov on 8/3/22.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase
import FirebaseStorage

struct DetailImageLoader: View {
    
    @State var url = ""
    
    var body: some View {
        VStack {
            if url != "" {
                AnimatedImage(url: URL(string: url)!)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 350)
                    .cornerRadius(12)
                    .padding(.top, -50)
            } else {
                Loader()
            }
        }
        .onAppear() {
            DispatchQueue.main.async {
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
}
