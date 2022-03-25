//
//  ImagePicker.swift
//  Elib
//
//  Created by Daniil Akmatov on 25/3/22.
//

import Foundation
import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Binding var isPickerShowign: Bool
    
    func makeUIViewController(context: Context) -> some UIViewController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}

class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var parent: ImagePicker
    
    init(_ picker: ImagePicker) {
        self.parent = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Run the code when the user has selected an image
        print("Image selected")
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // We were able to get image
            DispatchQueue.main.async {
                self.parent.selectedImage = image
            }
        }
        // Dismiss the picker
        parent.isPickerShowign = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Run the code when the user has cancelled the picker UI
        print("Cancelled selection")
        
        // Dismiss the picker
        parent.isPickerShowign = false
    }
}
