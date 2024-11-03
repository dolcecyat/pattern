//
//  DetailPresenter.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 14.10.2024.
//

import UIKit

protocol DetailPresentationProtocol: AnyObject {
    var viewController: DetailPatternDisplayLogic? {get set}
    var router: DetailRouterProtocol? {get set}
    func capitalizingFirstLetter(_ string:String) -> String 
    func numberOfRowsInComponentInPickerView() -> Int
    func titleForRowInPickerView(row: Int) -> String?
}

class DetailPresenter: DetailPresentationProtocol {
    weak var viewController: DetailPatternDisplayLogic?
    var router: DetailRouterProtocol?
    
    func capitalizingFirstLetter(_ string:String) -> String {
        let first = string.prefix(1).capitalized
        let other = string.dropFirst()
        return first + other
    }
    
    func numberOfRowsInComponentInPickerView() -> Int {
        PatternsModel.PatternsCategory.allCases.count
    }

    func titleForRowInPickerView(row: Int) -> String? {
        PatternsModel.PatternsCategory.allCases.first(where: { $0.sectionNumber == row })?.description ?? ""
    }
}
