//
//  ChangeImage.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 17.11.2024.
//

import Foundation
import UIKit

class ChangeImage: UIImageView {
    
    let image1: UIImage?
    
    override init(image: UIImage?) {
        self.image1 = image
        super.init(image: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func rotate(open:Bool) {
        if open {
            ChangeImage.animate(withDuration: 0.5, delay: 0.1, animations: { [weak self] in
                self?.transform = CGAffineTransform(rotationAngle: 180.0 * 3.14/180.0)
            })
        } else {
            ChangeImage.animate(withDuration: 0.5, delay: 0.1, animations: { [weak self] in
                self?.transform = CGAffineTransform(rotationAngle: 0.0 * 3.14/180.0)
            })
        }
    }
}
