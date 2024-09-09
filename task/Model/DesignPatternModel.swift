//
//  DesignPatternModel.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 09.09.2024.
//

import Foundation

enum PatternsCategory {
       case Порождающие
       case Структурные
       case Поведенческие
      }

struct PatternsModel {

    let patternImage: String
    let patternName: String
    let patternDescription: String
    let category: PatternsCategory
    var isFavorite: Bool
    var numberOfViews: Int
}
