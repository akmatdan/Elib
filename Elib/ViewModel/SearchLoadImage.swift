//
//  SearchLoadImage.swift
//  Elib
//
//  Created by Daniil Akmatov on 13/4/22.
//

import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI

struct SearchLoadImage: View {

    @State var url = ""

    var body: some View {

        VStack {
            if url != "" {
                AnimatedImage(url: URL(string: url)!)
                    .resizable()
                    .frame(maxWidth: 90, minHeight: 130)
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
