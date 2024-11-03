//
//  HomeAssembly.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 24.09.2024.
//

import UIKit

final class HomeAssembly {
    
    func configurateOne(_ vc: HomeDisplayLogic) {
        let presenter = HomePresenter()
        let router = HomeRouter()
        vc.presenter = presenter
        presenter.viewController = vc
        presenter.router = router
        router.presenter = presenter
    }
    func configurateAddingVC(_ vc: AddingDisplayLogic) {
        let router = AddingRouter()
        let presenter = AddingPresenter()
        presenter.viewController = vc
        router.presenter = presenter
        presenter.router = router
        vc.presenter = presenter
    }
    
    func configurateDetailVC(_ vc: DetailPatternDisplayLogic) {
        let router = DetailRouter()
        let presenter = DetailPresenter()
        presenter.viewController = vc
        router.presenter = presenter
        presenter.router = router
        vc.presenter = presenter
    }
}
