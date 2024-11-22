//
//  Storage.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 17.11.2024.
//

import Foundation

enum Keys {
    static let behavioral = "behavioralStoredPatternsArray"
    static let generative = "generativeStoredPatternsArray"
    static let structural = "structuralStoredPatternsArray"
}

class Storage {
    
    let defaults = UserDefaults.standard
    
    static let shared = Storage()
    
    var behavioralStoredPatternsArray: [PatternsModel] {
        get {
            getFunc(key: Keys.behavioral)
        }
        set {
            setFunc(key: Keys.behavioral, newValue: newValue)
        }
    }
    
    var generativeStoredPatternsArray: [PatternsModel] {
        get {
            getFunc(key: Keys.generative)
        }
        set {
            setFunc(key: Keys.generative, newValue: newValue)
        }
    }
    
    var structuralStoredPatternsArray: [PatternsModel] {
        get {
            getFunc(key: Keys.structural)
        }
        set {
            setFunc(key: Keys.structural, newValue: newValue)
        }
    }
    
    // MARK: - Get Set funcs
    
    func getFunc(key: String) -> [PatternsModel] {
        if let data = defaults.value(forKey: key) as? Data {
            return try! PropertyListDecoder().decode([PatternsModel].self, from: data)
        }else {
            return [PatternsModel]()
        }
    }
    
    func setFunc(key: String, newValue: [PatternsModel]) {
        if let data = try? PropertyListEncoder().encode(newValue){
            defaults.set(data, forKey: key)
        }
    }
    // MARK: - Save func
    
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
    
    func deletePattern (indexPath: IndexPath){
        let gategory = PatternsModel.PatternsCategory.allCases.first(where: { $0.sectionNumber == indexPath.section })
        switch gategory {
        case .Поведенческие:
            Storage.shared.behavioralStoredPatternsArray.remove(at: indexPath.row)
        case .Структурные:
            Storage.shared.structuralStoredPatternsArray.remove(at: indexPath.row)
        case .Порождающие:
            Storage.shared.generativeStoredPatternsArray.remove(at: indexPath.row)
        case .none:
            print(Errors.DeletingCellError)
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
