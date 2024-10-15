//
//  DetailPresenter.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 14.10.2024.
//

import UIKit

protocol DetailPresentationProtocol: AnyObject{
    var viewController: DetailPatternDisplayLogic? {get set}
    var router: DetailRouterProtocol? {get set}
}

class DetailPresenter: DetailPresentationProtocol {
    weak var viewController: DetailPatternDisplayLogic?
    var router: DetailRouterProtocol?
}
