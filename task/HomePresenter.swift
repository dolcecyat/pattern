//
//  HomePresenter.swift
//  task
//
//  Created by Анатолий Коробских on 09.08.2024.
//

import UIKit

protocol HomePresentationProtocol: AnyObject{
    var viewController: HomeDisplayLogic? {get set}
   
}

class HomePresenter: HomePresentationProtocol {
    weak var viewController: HomeDisplayLogic?

}
