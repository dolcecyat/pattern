//
//  Storage.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 17.11.2024.
//

import Foundation

class Storage {
    let defaults = UserDefaults.standard

    static let shared = Storage()
    
    var behavioralStoredPatternsArray: [PatternsModel] {
        get {
            if let data = defaults.value(forKey: "behavioralStoredPatternsArray") as? Data {
                return try! PropertyListDecoder().decode([PatternsModel].self, from: data)
            }else {
                return [PatternsModel]()
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue){
                defaults.set(data, forKey: "behavioralStoredPatternsArray")
            }
        }
    }
    
    var generativeStoredPatternsArray: [PatternsModel] {
        get {
            if let data = defaults.value(forKey: "generativeStoredPatternsArray") as? Data {
                return try! PropertyListDecoder().decode([PatternsModel].self, from: data)
            }else {
                return [PatternsModel]()
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue){
                defaults.set(data, forKey: "generativeStoredPatternsArray")
            }
        }
    }
    
    var structuralStoredPatternsArray: [PatternsModel] {
        get {
            if let data = defaults.value(forKey: "structuralStoredPatternsArray") as? Data {
                return try! PropertyListDecoder().decode([PatternsModel].self, from: data)
            }else {
                return [PatternsModel]()
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue){
                defaults.set(data, forKey: "structuralStoredPatternsArray")
            }
        }
    }
    
    func savePattern(patternImage: Image, patternName: String ,patternDescription: String ,category: PatternsModel.PatternsCategory ,isFavorite: Bool, numberOfViews: Int) {
        let pattern  = PatternsModel(patternImage: patternImage, patternName: patternName, patternDescription: patternDescription, category:category, isFavorite: isFavorite, numberOfViews: numberOfViews)
        let gategory = PatternsModel.PatternsCategory.allCases.first(where: { $0 == category})
        switch gategory {
        case .Поведенческие:
            behavioralStoredPatternsArray.insert(pattern, at: 0)
        case .Структурные:
            structuralStoredPatternsArray.insert(pattern, at: 0)
        case .Порождающие:
            generativeStoredPatternsArray.insert(pattern, at: 0)
        case .none:
            print(Errors.SavingPattern)
        }
    }
    
    func upDatePattern(model: PatternsModel) {
        let gategory = PatternsModel.PatternsCategory.allCases.first(where: { $0 == model.category})
        switch gategory {
        case .Поведенческие:
            Storage.shared.behavioralStoredPatternsArray = Storage.shared.behavioralStoredPatternsArray.map { value in
                var newValue = value
                if value.patternName == model.patternName{
                    newValue.isFavorite.toggle()
                    return newValue }
                return newValue
            }
        case .Структурные:
            Storage.shared.structuralStoredPatternsArray = Storage.shared.structuralStoredPatternsArray.map { value in
                var newValue = value
                if value.patternName == model.patternName{
                    newValue.isFavorite.toggle()
                    return newValue }
                return newValue
            }
        case .Порождающие:
            Storage.shared.generativeStoredPatternsArray = Storage.shared.generativeStoredPatternsArray.map { value in
                var newValue = value
                if value.patternName == model.patternName{
                    newValue.isFavorite.toggle()
                    return newValue }
                return newValue
            }
        case .none:
            print(Errors.UpDatingPattern)
        }
    }
}
