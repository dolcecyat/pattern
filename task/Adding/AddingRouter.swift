//
//  AddingRouter.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 09.10.2024.
//

import UIKit

protocol AddingRouterProtocol: AnyObject {
    var presenter: AddingPresentationProtocol? {get set}
    func showHomeVCAfterAddingNewPattern()
}

class AddingRouter: AddingRouterProtocol {
    weak var presenter: AddingPresentationProtocol?
    
    // MARK: - Showing HomeVC after adding new
    
    func showHomeVCAfterAddingNewPattern() {
        presenter?.viewController?.navigationController?.popToRootViewController(animated: true)
    }
}
