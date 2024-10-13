//
//  HomeCellModel.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 14.09.2024.
//

import Foundation
import UIKit

struct HomeCellModel {
    var description: String
    var image: UIImage
    var name: String
    var viewNumber: Int
    var isFavorite: Bool
    var category: PatternsModel.PatternsCategory
}
