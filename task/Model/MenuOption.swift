//
//  MenuOption.swift
//  task
//
//  Created by Анатолий Коробских on 10.08.2024.
//
import UIKit

enum MenuOption: Int,CustomStringConvertible {
    
    case one
    case two
    case three
    case four
    case POPP
    case PP
    case AP
    case PSolid
    
    var description: String {
        switch self {
        case .one: return ""
        case .two: return ""
        case .three: return ""
        case .four : return ""
        case .POPP: return "Принципы ООП"
        case .PP: return "Паттерны проектирования"
        case .AP: return "Архитектурные паттерны"
        case .PSolid: return "Принципы SOLID"
            
        }
    }
    var image: UIImage {
        switch self {
            
        case .one: return UIImage(systemName: "arrow.right")!.withTintColor(UIColor(.white), renderingMode: .alwaysOriginal)
        case .two: return UIImage(systemName: "arrow.right")!.withTintColor(UIColor(.white), renderingMode: .alwaysOriginal)
        case .three: return UIImage(systemName: "arrow.right")!.withTintColor(UIColor(.white), renderingMode: .alwaysOriginal)
        case .four: return UIImage(systemName: "arrow.right")!.withTintColor(UIColor(.white), renderingMode: .alwaysOriginal)
        case .POPP: return UIImage(systemName: "arrow.right")!.withTintColor(UIColor(.white), renderingMode: .alwaysOriginal)
        case .PP: return UIImage(systemName: "arrow.right")!.withTintColor(UIColor(.white), renderingMode: .alwaysOriginal)
        case .AP: return UIImage(systemName: "arrow.right")!.withTintColor(UIColor(.white), renderingMode: .alwaysOriginal)
        case .PSolid: return UIImage(systemName: "arrow.right")!.withTintColor(UIColor(.white), renderingMode: .alwaysOriginal)
        }
    }
}
