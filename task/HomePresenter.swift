//
//  HomePresenter.swift
//  task
//
//  Created by Анатолий Коробских on 09.08.2024.
//

import UIKit

private enum Constans {
    static let structural = "Структурные"
    static let generative = "Порождающие"
    static let behavioral = "Поведенческие"
}

enum PatternCategory{
    static let structural = PatternsModel.PatternsCategory.Структурные
    static let generative = PatternsModel.PatternsCategory.Порождающие
    static let behavioral = PatternsModel.PatternsCategory.Поведенческие
}

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
        if group == PatternCategory.structural{
            structuralPatternsArray = arrayFiltered
        }else if group == PatternCategory.generative{
            genegativePatternsArray = arrayFiltered
        }else if group == PatternCategory.behavioral{
            behavioralPatternsArray = arrayFiltered
        }
    }
    
    // MARK: - Data for HomeTableView
    
    func getNumberOfSections () -> Int {
        3
    }
    
    func getSectionName (section: Int) -> String{
        var sectionName = ""
        if section == 0 {
            sectionName = Constans.behavioral
        }else if section == 1 {
            sectionName = Constans.generative
        }else if section == 2 {
            sectionName = Constans.structural
        }
        return sectionName
    }
    
    func countCells (section: Int) -> Int{
        var rowsInSection = 0
        if section == 0{
            rowsInSection = behavioralPatternsArray.count
        }else if section == 1 {
            rowsInSection = genegativePatternsArray.count
        }else if section == 2  {
            rowsInSection = structuralPatternsArray.count
        }
        return rowsInSection
    }
    
    func  cellInformation (indexPath: IndexPath) -> HomeCellModel{
        if indexPath.section == 0 {
            let modelPattern = behavioralPatternsArray[indexPath.row]
            let modelForCell = HomeCellModel(description: modelPattern.patternDescription, image: modelPattern.patternImage, name: modelPattern.patternName, viewNumber: modelPattern.numberOfViews, isFavorite: modelPattern.isFavorite)
          return modelForCell  
        } else if indexPath.section == 1 {
            let modelPattern = genegativePatternsArray[indexPath.row]
            let modelForCell = HomeCellModel(description: modelPattern.patternDescription, image: modelPattern.patternImage, name: modelPattern.patternName, viewNumber: modelPattern.numberOfViews, isFavorite: modelPattern.isFavorite)
            return modelForCell
        } else {
            let modelPattern = structuralPatternsArray[indexPath.row]
            let modelForCell = HomeCellModel(description: modelPattern.patternDescription, image: modelPattern.patternImage, name: modelPattern.patternName, viewNumber: modelPattern.numberOfViews, isFavorite: modelPattern.isFavorite)
            return modelForCell
        }
    }
    
    // MARK: - View number of pattern
    
    private func plusViews(patternInGroup: [PatternsModel],indexPath: IndexPath)-> Int{
        var views = patternInGroup[indexPath.row].numberOfViews
        views += 1
        return views
    }
    
    func selectPatternForDetails (indexPath: IndexPath) {
        if indexPath.section == 0 {
            behavioralPatternsArray[indexPath.row].numberOfViews = plusViews(patternInGroup:behavioralPatternsArray,indexPath: indexPath)
        }else if indexPath.section == 1 {
            genegativePatternsArray[indexPath.row].numberOfViews = plusViews(patternInGroup:genegativePatternsArray,indexPath: indexPath)
        }else if indexPath.section == 2{
            structuralPatternsArray[indexPath.row].numberOfViews = plusViews(patternInGroup:structuralPatternsArray,indexPath: indexPath)
        }
    }
}
