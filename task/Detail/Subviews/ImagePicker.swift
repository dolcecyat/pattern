//
//  ImagePicker.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 16.10.2024.
//

import Foundation
import UIKit

class ImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePickerController: UIImagePickerController?
    var complition: ((UIImage) -> ())?
    
    func showImagePicker(in viewController:UIViewController,complition: ((UIImage) -> ())?) {
        self.complition = complition
        imagePickerController = UIImagePickerController()
        imagePickerController?.delegate = self
        viewController.present(imagePickerController ?? UIImagePickerController(), animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.complition?(image)
            picker.dismiss(animated: true)
        }
    }
  
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
