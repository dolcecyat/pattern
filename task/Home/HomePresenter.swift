//
//  HomePresenter.swift
//  task
//
//  Created by Анатолий Коробских on 09.08.2024.
//

import UIKit
private enum Constants {
    static let emptyPatternModel = PatternsModel(patternImage: Image(withImage: UIImage(resource: .abstractFactory)), patternName: "", patternDescription: "", category: .Поведенческие, isFavorite: false, numberOfViews: 0)
}

protocol HomePresentationProtocol: AnyObject {
    var viewController: HomeDisplayLogic? {get set}
    var router: HomeRouterProtocol? {get set}
    
    func cellInformation (indexPath: IndexPath) -> PatternsModel
    func filteredPatterns(group: PatternsModel.PatternsCategory)
    func countCells (section: Int) -> Int
    func selectPatternForDetails (indexPath: IndexPath)
    func getSectionName (section: Int) -> String
    func getNumberOfSections () -> Int
    func deletePattern (indexPath: IndexPath)
    func openPatternDetails (indexPath:IndexPath)
    func addingPatternToFavorite (indexPath: IndexPath)
    func openAddingVC()
    func getNewpattern(modelOfNewPattern: PatternsModel)
    func editPattertnAt(pattern: PatternsModel)
    func searchingPattern(searchText: String)
    func countSearchingCells() -> Int
    func searchingCellInformation(indexPath:IndexPath) -> PatternsModel
    func addingSearchedPatternToFavorite (model: PatternsModel, isFavorite: Bool)
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
        PatternsModel.PatternsCategory.allCases.count
    }
    
    func getSectionName (section: Int) -> String {
        PatternsModel.PatternsCategory.allCases.first(where: { $0.sectionNumber == section })?.description ?? ""
    }

    func countCells (section: Int) -> Int {
        let gategory = PatternsModel.PatternsCategory.allCases.first(where: { $0.sectionNumber == section })
        var rowsInSection = 0
        switch gategory{
        case .Поведенческие:
            rowsInSection = Storage.shared.behavioralStoredPatternsArray.count
        case .Структурные:
            rowsInSection = Storage.shared.structuralStoredPatternsArray.count
        case .Порождающие:
            rowsInSection = Storage.shared.generativeStoredPatternsArray.count
        case .none:
            print(Errors.CountCellsError)
        }
        return rowsInSection
    }
    
    func  cellInformation (indexPath: IndexPath) -> PatternsModel {
        let gategory = PatternsModel.PatternsCategory.allCases.first(where: { $0.sectionNumber == indexPath.section })
        switch gategory {
        case .Поведенческие:
            let modelPattern = Storage.shared.behavioralStoredPatternsArray[indexPath.row]
            return modelPattern
        case .Порождающие:
            let modelPattern = Storage.shared.generativeStoredPatternsArray[indexPath.row]
            return modelPattern
        case .Структурные:
            let modelPattern = Storage.shared.structuralStoredPatternsArray[indexPath.row]
            return modelPattern
        case .none:
            return Constants.emptyPatternModel
        }
    }
    
    // MARK: - View number of pattern

    func selectPatternForDetails(indexPath: IndexPath) {
        let gategory = PatternsModel.PatternsCategory.allCases.first(where: { $0.sectionNumber == indexPath.section })
        switch gategory{
        case .Поведенческие:
            Storage.shared.behavioralStoredPatternsArray[indexPath.row].numberOfViews = plusViews(patternInGroup:Storage.shared.behavioralStoredPatternsArray, indexPath: indexPath)
        case .Структурные:
            Storage.shared.structuralStoredPatternsArray[indexPath.row].numberOfViews = plusViews(patternInGroup:Storage.shared.structuralStoredPatternsArray, indexPath: indexPath)
        case .Порождающие:
            Storage.shared.generativeStoredPatternsArray[indexPath.row].numberOfViews = plusViews(patternInGroup:Storage.shared.generativeStoredPatternsArray, indexPath: indexPath)
        case .none:
            print(Errors.SelectingCellError)
        }
    }
    
    private func plusViews(patternInGroup: [PatternsModel], indexPath: IndexPath)-> Int {
        var views = patternInGroup[indexPath.row].numberOfViews
        views += 1
        return views
    }
    
    // MARK: - Deleting Patterns
    
    func deletePattern(indexPath: IndexPath) {
        let gategory = PatternsModel.PatternsCategory.allCases.first(where: { $0.sectionNumber == indexPath.section })
        switch gategory{
        case .Поведенческие:
            Storage.shared.behavioralStoredPatternsArray.remove(at: indexPath.row)
            viewController?.updateData()
        case .Структурные:
            Storage.shared.structuralStoredPatternsArray.remove(at: indexPath.row)
            viewController?.updateData()
        case .Порождающие:
            Storage.shared.generativeStoredPatternsArray.remove(at: indexPath.row)
            viewController?.updateData()
        case .none:
            print(Errors.DeletingCellError)
        }
    }
    
    // MARK: - Opening details about pattern
    
    func openPatternDetails(indexPath: IndexPath) {
        currentOpenedDetailPatternAtIndexPath = indexPath
        let gategory = PatternsModel.PatternsCategory.allCases.first(where: { $0.sectionNumber == indexPath.section })
        switch gategory {
        case .Поведенческие:
            router?.showDetailVC(patternModel: Storage.shared.behavioralStoredPatternsArray[indexPath.row])
        case .Структурные:
            router?.showDetailVC(patternModel: Storage.shared.structuralStoredPatternsArray[indexPath.row])
        case .Порождающие:
            router?.showDetailVC(patternModel: Storage.shared.generativeStoredPatternsArray[indexPath.row])
        case .none:
            print(Errors.OpeningDetailError)
        }
    }
    
    // MARK: - Adding to Favorite
    
    func addingPatternToFavorite(indexPath: IndexPath) {
        print(indexPath)
        let gategory = PatternsModel.PatternsCategory.allCases.first(where: { $0.sectionNumber == indexPath.section })
        switch gategory {
        case .Поведенческие:
            Storage.shared.behavioralStoredPatternsArray[indexPath.row].isFavorite = !Storage.shared.behavioralStoredPatternsArray[indexPath.row].isFavorite
        case .Структурные:
            Storage.shared.structuralStoredPatternsArray[indexPath.row].isFavorite.toggle()
        case .Порождающие:
            Storage.shared.generativeStoredPatternsArray[indexPath.row].isFavorite.toggle()
        case .none:
            print(Errors.ChangingFavoriteError)
        }
        viewController?.updateData()
    }
    
    func addingSearchedPatternToFavorite (model: PatternsModel, isFavorite: Bool) {
        Storage.shared.upDatePattern(model: model)
        viewController?.updateData()
    }
    
    // MARK: - Open AddVC
    
    func openAddingVC() {
        router?.showAddingVC()
    }
    
    // MARK: - AddingNewPattern
    
    func getNewpattern(modelOfNewPattern: PatternsModel) {
        Storage.shared.savePattern(patternImage: modelOfNewPattern.patternImage, patternName: modelOfNewPattern.patternName, patternDescription: modelOfNewPattern.patternDescription, category: modelOfNewPattern.category, isFavorite: modelOfNewPattern.isFavorite, numberOfViews: modelOfNewPattern.numberOfViews)
        viewController?.updateData()
    }
    
    // MARK: - Editing Pattern
    
    func editPattertnAt(pattern: PatternsModel) {
        deletePattern(indexPath: currentOpenedDetailPatternAtIndexPath)
        let gategory = PatternsModel.PatternsCategory.allCases.first(where: { $0.description == pattern.category.description })
        switch gategory{
        case .Поведенческие:
            Storage.shared.behavioralStoredPatternsArray.insert(pattern, at: 0)
            viewController?.updateData()
        case .Структурные:
            Storage.shared.structuralStoredPatternsArray.insert(pattern, at: 0)
            viewController?.updateData()
        case .Порождающие:
            Storage.shared.generativeStoredPatternsArray.insert(pattern, at: 0)
            viewController?.updateData()
        case .none:
            print(Errors.FilteringPatternsError)
        }
    }
    
    // MARK: - Searching
    
    func searchingCellInformation(indexPath:IndexPath) -> PatternsModel {
        let modelForCell = searchedPatterns[indexPath.row]
        return modelForCell
    }
    
    func searchingPattern(searchText: String) {
        let allPatternsForSearching = Storage.shared.behavioralStoredPatternsArray + Storage.shared.structuralStoredPatternsArray + Storage.shared.generativeStoredPatternsArray
       searchedPatterns = allPatternsForSearching.filter { $0.patternName.prefix(searchText.count) == searchText }
    }
    
    func countSearchingCells() -> Int {
        searchedPatterns.count
    }
}
