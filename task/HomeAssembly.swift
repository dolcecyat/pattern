//
//  HomeAssembly.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 24.09.2024.
//

import UIKit

final class HomeAssembly{
    func configurateOne(_ vc: HomeDisplayLogic) {
        let presenter = HomePresenter()
        let router = HomeRouter()
//        let vcAdd = AddingViewController()
        vc.presenter = presenter
        presenter.viewController = vc
        presenter.router = router
        router.presenter = presenter
        
    }
    func configurateSecondVC(_ vc: AddingDisplayLogic) {
        let router = AddingRouter()
        let presenter = AddingPresenter()
        presenter.viewController = vc
        router.presenter = presenter
        presenter.router = router
        vc.presenter = presenter
    }
}
