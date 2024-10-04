//
//  Errors.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 04.10.2024.
//

import Foundation

enum Errors {
    case CountCellsError
    case FilteringPatternsError
    case SelectingCellError
    case DeletingCellError
    case OpeningDetailError
    case ChangingFavoriteError
    
    
    var description: String {
        switch self {
            
        case .CountCellsError:
            return "Error with counting cells"
        case .FilteringPatternsError:
            return "Error with filtering of patterns"
        case .SelectingCellError:
            return "Error with selecting cell"
        case .DeletingCellError:
            return "Error with deleting cell"
        case .OpeningDetailError:
            return "Error with opening details"
        case .ChangingFavoriteError:
            return "Error with changing isFavorite"
        }
    }
}
