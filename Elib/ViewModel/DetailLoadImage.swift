//
//  DetailLoadImage.swift
//  Elib
//
//  Created by Daniil Akmatov on 12/4/22.
//

import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI

struct DetailLoadImage: View {

    @State var url = ""

    var body: some View {

        VStack {
            if url != "" {
                AnimatedImage(url: URL(string: url)!)
                    .resizable()
                    
                    .frame(maxWidth: 240, maxHeight: 320)
                    .padding(.top, -20)
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
