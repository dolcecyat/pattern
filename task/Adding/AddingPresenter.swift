//
//  AddingPresenter.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 09.10.2024.
//

import UIKit

protocol AddingPresentationProtocol: AnyObject{
    var viewController: AddingDisplayLogic? {get set}
    var router: AddingRouterProtocol? {get set}
    func addButtonPressed()
}

class AddingPresenter: AddingPresentationProtocol {
    weak var viewController: AddingDisplayLogic?
    var router: AddingRouterProtocol?
    
    // MARK: - Adding new pattern
    func addButtonPressed() {
        router?.showHomeVCAfterAddingNewPattern()
    }
}
