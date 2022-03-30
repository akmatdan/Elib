//
//  ImageLoader.swift
//  Elib
//
//  Created by Daniil Akmatov on 7/3/22.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase
import FirebaseStorage

struct ImageLoader: View {
    
    @State var url = ""
    
    var body: some View {
        VStack {
            if url != "" {
                AnimatedImage(url: URL(string: url)!)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .cornerRadius(5)
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

struct Loader: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<Loader>) -> UIActivityIndicatorView {
        
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        return indicator
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Loader>) {
        
    }
}
