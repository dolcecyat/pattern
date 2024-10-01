//
//  DesignPatternModel.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 09.09.2024.
//

import Foundation


struct PatternsModel {
    let patternImage: String
    let patternName: String
    let patternDescription: String
    let category: PatternsCategory
    var isFavorite: Bool
    var numberOfViews: Int
    
    enum PatternsCategory: String {
           case Порождающие = "Порождающие"
           case Структурные = "Структурные"
           case Поведенческие = "Поведенческие"
          }

}
