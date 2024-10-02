//
//  HomePresenter.swift
//  task
//
//  Created by Анатолий Коробских on 09.08.2024.
//

import UIKit

#warning("думаю эти два энума ты сможешь убрать. постарайся их убрать и все пофиксить")

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
    
    #warning("у тебя group это енум, зачем нужно иф елсы если ты можешь свичнуться. более того подход который не хаканчивается на обработке else, а заканчивается на else if, подразумевает что у тебя могут быть еще кейсы. но у тебя же их не может быть...сделай строгую завязку на кейсах и тогда ниче никогда не сломается. даже если появятся кейс ноыве у человека выйдут ошибки, которые он быстро пофиксит добавив новый кейс, при подходе с ifelse комплиятор не попросит его добавлять новые случаи, а просто выйдет из функции, таким образом будет поломана работа, а так это инструкция на дурака, мол если ты там поменял, будь добр и тут поменять")
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
    
    #warning("это не есть хорошо.. а если у тебя будут динамиеские данные?? ты же по логике хавязываешься строго на колличестве кейсов в PatternsCategory, так отталкивайся от этого. спойлер - ты можешь конвертнуть массив и получить только категории, ты получишь дохрена элементов чисто категорий, затем ты должна получить только уникальные категории, а их будет всего три. в этом тебе поможет определенная коллекция, которую ты знаешь. говорю загадками, чтобы ты сама догадалась. я думаю, ты сможешь это сделать. Второй подход через allCases. реализуй два подхода потом на созвоне обсудим")
    
    func getNumberOfSections () -> Int {
        3
    }
    
    #warning("меня напрягает что ты везде используешь эту реализацию с нулем и единицей. я знаю что ты это врядли бы сделала, поэтому я тебе написал. изучи все что я сделал и по аткому же принципу сделай все остальные функции резуольтат которых завязан на секции. потом с тобой обсудим. важно что порядок в котором отображаются эти элементы должен быть сохранен. можешь зайти в енум и посмотреть. он возвращает порядковый номер кейса в енуме. если ты поменяешь местами, то все сломается, но если добавишь вниз дополнительный кейс, то будет работать ок")
    func getSectionName (section: Int) -> String {
        return PatternsModel.PatternsCategory.allCases.first(where: { $0.sectionNumber == section })?.description ?? ""
    }
#warning("передалеть как в примере выше")
    func countCells (section: Int) -> Int{
        var rowsInSection = 0
        if section == 0 {
            rowsInSection = behavioralPatternsArray.count
        }else if section == 1 {
            rowsInSection = genegativePatternsArray.count
        }else if section == 2  {
            rowsInSection = structuralPatternsArray.count
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
                
#warning("так как .first выкидывает опционал, его надо обработать, в будущем это необходимо будет когда ты будешь работать с сетью, так как там может прийти нил, поэтому мы здесь решаем во первых проблему о которой я сказал ранее, что мы завязаны на кейсах, и если кто то добавит кейс, то ему придется добавть кейс и сюда, соответственно логика не будет сломана даже если кто то захочет постараться, во вторых ну эта обработка с нилом вынужденная так как чертов .first опционал....")
            }
        }
        
        
        
//        if indexPath.section == 0 {
//            let modelPattern = behavioralPatternsArray[indexPath.row]
//            let modelForCell = HomeCellModel(description: modelPattern.patternDescription, image: modelPattern.patternImage, name: modelPattern.patternName, viewNumber: modelPattern.numberOfViews, isFavorite: modelPattern.isFavorite)
//          return modelForCell
//        } else if indexPath.section == 1 {
//            let modelPattern = genegativePatternsArray[indexPath.row]
//            let modelForCell = HomeCellModel(description: modelPattern.patternDescription, image: modelPattern.patternImage, name: modelPattern.patternName, viewNumber: modelPattern.numberOfViews, isFavorite: modelPattern.isFavorite)
//            return modelForCell
//        } else {
//            let modelPattern = structuralPatternsArray[indexPath.row]
//            let modelForCell = HomeCellModel(description: modelPattern.patternDescription, image: modelPattern.patternImage, name: modelPattern.patternName, viewNumber: modelPattern.numberOfViews, isFavorite: modelPattern.isFavorite)
//            return modelForCell
//        }
//    }
    
    // MARK: - View number of pattern
    
    private func plusViews(patternInGroup: [PatternsModel],indexPath: IndexPath)-> Int{
        var views = patternInGroup[indexPath.row].numberOfViews
        views += 1
        return views
    }
    #warning("поменяй лучше местами эти две функции тогда будет красивше, а то я сразу не понял, что верхняя вызывается в нижней) так понятнее будет")
    #warning("ну и поменяй чтоб небыло зависимости на 0, 1, 2")
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
