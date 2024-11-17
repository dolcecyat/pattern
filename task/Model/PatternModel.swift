//
//  DesignPatternModel.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 09.09.2024.
//

import Foundation
import UIKit


struct PatternsModel: Codable {
    var patternImage: Image
    var patternName: String
    var patternDescription: String
    var category: PatternsCategory
    var isFavorite: Bool
    var numberOfViews: Int
    
    init(patternImage: Image, patternName: String, patternDescription: String, category: PatternsCategory, isFavorite: Bool, numberOfViews: Int) {
        self.patternImage = patternImage
        self.patternName = patternName
        self.patternDescription = patternDescription
        self.category = category
        self.isFavorite = isFavorite
        self.numberOfViews = numberOfViews
    }
  
    
    enum PatternsCategory: CaseIterable, Codable {
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
