//
//  HomeAssembly.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 24.09.2024.
//

import UIKit

final class HomeAssembly{
    func configurate(_ vc: HomeDisplayLogic) {
        let presenter = HomePresenter()
        let router = HomeRouter()
        vc.presenter = presenter
        presenter.viewController = vc
        presenter.router = router
        router.presenter = presenter
    }
}
