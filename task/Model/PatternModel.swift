//
//  DesignPatternModel.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 09.09.2024.
//

import Foundation
import UIKit


struct PatternsModel {
    var patternImage: UIImage
    var patternName: String
    var patternDescription: String
    var category: PatternsCategory
    var isFavorite: Bool
    var numberOfViews: Int
    
    enum PatternsCategory: CaseIterable {
        case Поведенческие
        case Порождающие
        case Структурные
        
        var description: String {
            switch self {
            case .Порождающие:
                return "Порождающие"
            case .Структурные:
                return "Структурные"
            case .Поведенческие:
                return "Поведенческие"
            }
        }

        var sectionNumber: Int {
            return PatternsCategory.allCases.firstIndex(of: self) ?? 0
        }
    }
}
