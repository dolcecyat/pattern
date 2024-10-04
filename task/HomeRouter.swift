//
//  HomeRouter.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 24.09.2024.
//

import UIKit

protocol HomeRouterProtocol: AnyObject {
    var presenter: HomePresentationProtocol? {get set}
    func showDetailVC(patternName: String)
}

class HomeRouter: HomeRouterProtocol {
    
    weak var presenter: HomePresentationProtocol?

    func showDetailVC(patternName: String) {
        let newVC = DetailPatternViewController()
        presenter?.viewController?.navigationController?.pushViewController(newVC, animated: true)
    }

}
