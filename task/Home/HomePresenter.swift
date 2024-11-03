//
//  HomePresenter.swift
//  task
//
//  Created by Анатолий Коробских on 09.08.2024.
//

import UIKit
private enum Constants {
    static let emptyPatternModel = HomeCellModel(description: "", image: UIImage(resource: .abstractFactory), name: "", viewNumber: 0, isFavorite: false, category: .Поведенческие)
}

protocol HomePresentationProtocol: AnyObject {
    var viewController: HomeDisplayLogic? {get set}
    var router: HomeRouterProtocol? {get set}
    
    func cellInformation (indexPath: IndexPath) -> HomeCellModel
    func filteredPatterns(group: PatternsModel.PatternsCategory)
    func countCells (section: Int) -> Int
    func selectPatternForDetails (indexPath: IndexPath)
    func getSectionName (section: Int) -> String
    func getNumberOfSections () -> Int
    func deletePattern (indexPath: IndexPath)
    func openPatternDetails (indexPath:IndexPath)
    func addingPatternToFavorite (indexPath: IndexPath, isFavorite: Bool)
    func openAddingVC()
    func getNewpattern(modelOfNewPattern: PatternsModel)
    func editPattertnAt(pattern: PatternsModel)
    func searchingPattern(searchText: String)
    func countSearchingCells() -> Int
    func searchingCellInformation(indexPath:IndexPath) -> HomeCellModel
}

class HomePresenter: HomePresentationProtocol {

    //MARK: - MVP Properties
    
    weak var viewController: HomeDisplayLogic?
    var router: HomeRouterProtocol?
    
    // MARK: - Data Properties
    
    var cellData = PatternData().patternData
    
    var searchedPatterns = [PatternsModel]()
    var currentOpenedDetailPatternAtIndexPath: IndexPath = [0,0]
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
            print(Errors.FilteringPatternsError)
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

    func countCells (section: Int) -> Int {
        let gategory = PatternsModel.PatternsCategory.allCases.first(where: { $0.sectionNumber == section })
        var rowsInSection = 0
        switch gategory{
        case .Поведенческие:
            rowsInSection = behavioralPatternsArray.count
        case .Структурные:
            rowsInSection = structuralPatternsArray.count
        case .Порождающие:
            rowsInSection = genegativePatternsArray.count
        case .none:
            print(Errors.CountCellsError)
        }
        return rowsInSection
    }
    
    func  cellInformation (indexPath: IndexPath) -> HomeCellModel {
        let gategory = PatternsModel.PatternsCategory.allCases.first(where: { $0.sectionNumber == indexPath.section })
        let categoryName = PatternsModel.PatternsCategory.allCases.first(where: { $0.sectionNumber == indexPath.section }) ?? .Поведенческие
            switch gategory {
            case .Поведенческие:
                let modelPattern = behavioralPatternsArray[indexPath.row]
                let modelForCell = HomeCellModel(description: modelPattern.patternDescription, image: modelPattern.patternImage, name: modelPattern.patternName, viewNumber: modelPattern.numberOfViews, isFavorite: modelPattern.isFavorite, category: categoryName)
              return modelForCell
            case .Порождающие:
                let modelPattern = genegativePatternsArray[indexPath.row]
                let modelForCell = HomeCellModel(description: modelPattern.patternDescription, image: modelPattern.patternImage, name: modelPattern.patternName, viewNumber: modelPattern.numberOfViews, isFavorite: modelPattern.isFavorite,category: categoryName)
              return modelForCell
            case .Структурные:
                let modelPattern = structuralPatternsArray[indexPath.row]
                let modelForCell = HomeCellModel(description: modelPattern.patternDescription, image: modelPattern.patternImage, name: modelPattern.patternName, viewNumber: modelPattern.numberOfViews, isFavorite: modelPattern.isFavorite,category: categoryName)
              return modelForCell
          case .none:
                return Constants.emptyPatternModel
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
            print(Errors.SelectingCellError)
        }
    }
    
    private func plusViews(patternInGroup: [PatternsModel],indexPath: IndexPath)-> Int {
        var views = patternInGroup[indexPath.row].numberOfViews
        views += 1
        return views
    }
    
    // MARK: - Deleting Patterns
    
    func deletePattern (indexPath: IndexPath) {
        let gategory = PatternsModel.PatternsCategory.allCases.first(where: { $0.sectionNumber == indexPath.section })
        switch gategory{
        case .Поведенческие:
            behavioralPatternsArray.remove(at: indexPath.row)
            viewController?.updateData()
        case .Структурные:
            structuralPatternsArray.remove(at: indexPath.row)
            viewController?.updateData()
        case .Порождающие:
            genegativePatternsArray.remove(at: indexPath.row)
            viewController?.updateData()
        case .none:
            print(Errors.DeletingCellError)
        }
    }
    
    // MARK: - Opening details about pattern
    
    func openPatternDetails (indexPath: IndexPath) {
        let gategory = PatternsModel.PatternsCategory.allCases.first(where: { $0.sectionNumber == indexPath.section })
        switch gategory {
        case .Поведенческие:
            router?.showDetailVC(patternModel: behavioralPatternsArray[indexPath.row])
        case .Структурные:
            router?.showDetailVC(patternModel: structuralPatternsArray[indexPath.row])
        case .Порождающие:
            router?.showDetailVC(patternModel: genegativePatternsArray[indexPath.row])
        case .none:
            print(Errors.OpeningDetailError)
        }
    }
    
    // MARK: - Adding to Favorite
    
    func addingPatternToFavorite (indexPath: IndexPath, isFavorite: Bool) {
        let gategory = PatternsModel.PatternsCategory.allCases.first(where: { $0.sectionNumber == indexPath.section })
        switch gategory {
        case .Поведенческие:
            behavioralPatternsArray[indexPath.row].isFavorite.toggle()
        case .Структурные:
            structuralPatternsArray[indexPath.row].isFavorite.toggle()
        case .Порождающие:
            genegativePatternsArray[indexPath.row].isFavorite.toggle()
        case .none:
            print(Errors.ChangingFavoriteError)
        }
        viewController?.updateData()
    }
    
    // MARK: - Open AddVC
    
    func openAddingVC() {
        router?.showAddingVC()
    }
    
    // MARK: - AddingNewPattern
    
    func getNewpattern(modelOfNewPattern: PatternsModel) {
        let gategory = PatternsModel.PatternsCategory.allCases.first(where: { $0.description == modelOfNewPattern.category.description })
        switch gategory{
        case .Поведенческие:
            behavioralPatternsArray.append(modelOfNewPattern)
            viewController?.updateData()
        case .Структурные:
            structuralPatternsArray.append(modelOfNewPattern)
            viewController?.updateData()
        case .Порождающие:
            genegativePatternsArray.append(modelOfNewPattern)
            viewController?.updateData()
        case .none:
            print(Errors.FilteringPatternsError)
        }
    }
    
    // MARK: - Editing Pattern
    
    func editPattertnAt(pattern: PatternsModel) {
        deletePattern(indexPath: currentOpenedDetailPatternAtIndexPath)
        let gategory = PatternsModel.PatternsCategory.allCases.first(where: { $0.description == pattern.category.description })
        switch gategory{
        case .Поведенческие:
            behavioralPatternsArray.insert(pattern, at: 0)
            viewController?.updateData()
        case .Структурные:
            structuralPatternsArray.insert(pattern, at: 0)
            viewController?.updateData()
        case .Порождающие:
            genegativePatternsArray.insert(pattern, at: 0)
            viewController?.updateData()
        case .none:
            print(Errors.FilteringPatternsError)
        }
    }
    
    // MARK: - Searching
    
    func searchingCellInformation(indexPath:IndexPath) -> HomeCellModel {
        let modelForCell = searchedPatterns[indexPath.row]
        let cellModel = HomeCellModel(description: modelForCell.patternDescription, image: modelForCell.patternImage, name: modelForCell.patternName, viewNumber: modelForCell.numberOfViews, isFavorite: modelForCell.isFavorite, category: modelForCell.category)
        return cellModel
    }
    
    func searchingPattern(searchText: String) {
        let allPatternsForSearching = behavioralPatternsArray + structuralPatternsArray + genegativePatternsArray
       searchedPatterns = allPatternsForSearching.filter { $0.patternName.prefix(searchText.count) == searchText }
    }
    
    func countSearchingCells() -> Int {
        searchedPatterns.count
    }
}
