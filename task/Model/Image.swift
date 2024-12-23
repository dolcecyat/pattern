//
//  Image.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 17.11.2024.
//

import Foundation
import UIKit

struct Image: Codable {
    
    let imageData: Data?
    
    init(withImage image: UIImage) {
        self.imageData = image.pngData()
    }
    
    func getImage() -> UIImage? {
        guard let imageData = self.imageData else {
            return nil
        }
        let image = UIImage(data: imageData)
        
        return image
    }
}
