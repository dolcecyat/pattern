//
//  HomeRouter.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 24.09.2024.
//

import UIKit

protocol HomeRouterProtocol: AnyObject {
    var presenter: HomePresentationProtocol? {get set}
}

class HomeRouter: HomeRouterProtocol {
    weak var presenter: HomePresentationProtocol?
}
