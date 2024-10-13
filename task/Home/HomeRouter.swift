//
//  HomeRouter.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 24.09.2024.
//

import UIKit

protocol HomeRouterProtocol: AnyObject {
    var presenter: HomePresentationProtocol? {get set}
    func showDetailVC(patternModel: PatternsModel)
    func showAddingVC()
    func showHomeVCAfterAddingNewPattern(model: PatternsModel)
}

class HomeRouter: HomeRouterProtocol {
    
     weak var presenter: HomePresentationProtocol?

    func showDetailVC(patternModel: PatternsModel) {
        let VCToOpen = DetailPatternViewController()
        VCToOpen.model = patternModel
        presenter?.viewController?.navigationController?.pushViewController(VCToOpen, animated: true)
    }

    func showAddingVC(){
        let VCToOpen = AddingViewController()
        VCToOpen.closure = { value in
            self.presenter?.getNewpattern(modelOfNewPattern: value)
            print(1)
        }
        presenter?.viewController?.navigationController?.pushViewController(VCToOpen, animated: true)
    }
    func showHomeVCAfterAddingNewPattern(model: PatternsModel){
        presenter?.viewController?.navigationController?.popViewController(animated: true)
    }
}
