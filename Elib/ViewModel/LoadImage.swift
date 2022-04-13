///
///  LoadImage.swift
///  Elib
///
///  Created by Daniil Akmatov on 10/4/22.
///

import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI

struct LoadImage: View {

    @State var url = ""

    var body: some View {

        VStack {
            if url != "" {
                AnimatedImage(url: URL(string: url)!)
                    .resizable()
                    .frame(maxWidth: 130, maxHeight: 170)
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
                DispatchQueue.main.async {
                    self.url = "\(url!)"
                }
                
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
