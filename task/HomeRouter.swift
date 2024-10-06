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
        presenter?.viewController?.navigationController?.pushViewController(VCToOpen, animated: true)
    }
}
