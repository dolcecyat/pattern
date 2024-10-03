//
//  HomePresenter.swift
//  task
//
//  Created by Анатолий Коробских on 09.08.2024.
//

import UIKit

protocol HomePresentationProtocol: AnyObject{
    var viewController: HomeDisplayLogic? {get set}
    var router: HomeRouterProtocol? {get set}
    func cellInformation (indexPath: IndexPath) -> HomeCellModel
    func filteredPatterns(group: PatternsModel.PatternsCategory)
    func countCells (section: Int) -> Int
    func selectPatternForDetails (indexPath: IndexPath)
    func getSectionName (section: Int) -> String
    func getNumberOfSections () -> Int
}

class HomePresenter: HomePresentationProtocol {
    
    //MARK: - MVP Properties
    
    weak var viewController: HomeDisplayLogic?
    var router: HomeRouterProtocol?
    
    // MARK: - Data Properties
    
    var cellData = PatternData().patternData
    
    var behavioralPatternsArray: [PatternsModel] = []
    var genegativePatternsArray: [PatternsModel] = []
    var structuralPatternsArray: [PatternsModel] = []
    
    // MARK: - Filtering Patterns
    
    func filteredPatterns(group: PatternsModel.PatternsCategory) {
        let arrayFiltered = cellData.filter { $0.category == group }
        let gategory = PatternsModel.PatternsCategory.allCases.first(where: { $0.description == group.description })
        switch gategory{
        case .Поведенческие:
            behavioralPatternsArray = arrayFiltered
        case .Структурные:
            structuralPatternsArray = arrayFiltered
        case .Порождающие:
            genegativePatternsArray = arrayFiltered
        case .none:
            print("Error with filtering of patterns")
        }

    }
    
    // MARK: - Data for HomeTableView
    
    func getNumberOfSections () -> Int {
        let filteredCategories = cellData.map { $0.category }
        let setOfUniqueCategories = Set(filteredCategories)
        let countCategoriesFromsetOfUniqueCategories = setOfUniqueCategories.count
        return countCategoriesFromsetOfUniqueCategories
//        PatternsModel.PatternsCategory.allCases.count
    }
    
    func getSectionName (section: Int) -> String {
    
        return PatternsModel.PatternsCategory.allCases.first(where: { $0.sectionNumber == section })?.description ?? ""
    }

    func countCells (section: Int) -> Int{
        let gategory = PatternsModel.PatternsCategory.allCases.first(where: { $0.sectionNumber == section })
        var rowsInSection = 0
        switch gategory{
        case .Поведенческие:
            rowsInSection = behavioralPatternsArray.count
        case .Структурные:
            rowsInSection = genegativePatternsArray.count
        case .Порождающие:
            rowsInSection = genegativePatternsArray.count
        case .none:
            print("Error with counting cells")
        }
        return rowsInSection
    }
    
    func  cellInformation (indexPath: IndexPath) -> HomeCellModel {
        let gategory = PatternsModel.PatternsCategory.allCases.first(where: { $0.sectionNumber == indexPath.section })
            switch gategory {
            case .Поведенческие:
                let modelPattern = behavioralPatternsArray[indexPath.row]
                let modelForCell = HomeCellModel(description: modelPattern.patternDescription, image: modelPattern.patternImage, name: modelPattern.patternName, viewNumber: modelPattern.numberOfViews, isFavorite: modelPattern.isFavorite)
              return modelForCell
            case .Порождающие:
                let modelPattern = genegativePatternsArray[indexPath.row]
                let modelForCell = HomeCellModel(description: modelPattern.patternDescription, image: modelPattern.patternImage, name: modelPattern.patternName, viewNumber: modelPattern.numberOfViews, isFavorite: modelPattern.isFavorite)
              return modelForCell
            case .Структурные:
                let modelPattern = structuralPatternsArray[indexPath.row]
                let modelForCell = HomeCellModel(description: modelPattern.patternDescription, image: modelPattern.patternImage, name: modelPattern.patternName, viewNumber: modelPattern.numberOfViews, isFavorite: modelPattern.isFavorite)
              return modelForCell
            case .none:
               return HomeCellModel(description: "", image: "", name: "", viewNumber: 0, isFavorite: false)
            }
        }
    // MARK: - View number of pattern

    func selectPatternForDetails (indexPath: IndexPath) {
        let gategory = PatternsModel.PatternsCategory.allCases.first(where: { $0.sectionNumber == indexPath.section })
        switch gategory{
        case .Поведенческие:
            behavioralPatternsArray[indexPath.row].numberOfViews = plusViews(patternInGroup:behavioralPatternsArray,indexPath: indexPath)
        case .Структурные:
            structuralPatternsArray[indexPath.row].numberOfViews = plusViews(patternInGroup:structuralPatternsArray,indexPath: indexPath)
        case .Порождающие:
            genegativePatternsArray[indexPath.row].numberOfViews = plusViews(patternInGroup:genegativePatternsArray,indexPath: indexPath)
        case .none:
            print("Error with selecting cell")
        }
    }
    
    private func plusViews(patternInGroup: [PatternsModel],indexPath: IndexPath)-> Int{
        var views = patternInGroup[indexPath.row].numberOfViews
        views += 1
        return views
    }
}
