//
//  DetailRouter.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 14.10.2024.
//

import UIKit

protocol DetailRouterProtocol: AnyObject {
    var presenter: DetailPresentationProtocol? {get set}
   
}

class DetailRouter: DetailRouterProtocol {
    weak var presenter: DetailPresentationProtocol?
}
