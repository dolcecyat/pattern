//
//  ContainerController.swift
//  task
//
//  Created by Анатолий Коробских on 09.08.2024.
//

import UIKit

class ContainerController: UIViewController {
    
    
    // MARK: - Properties
    var menuController: UIViewController!
    var centreController: UIViewController!
    var isExpended = false
    
    
    // MARK: - Init
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       configureHomeController()
      
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    // MARK: - Handlers
    
    
    
    func configureHomeController(){
        let homeController = HomeViewController()
        homeController.delegate = self
        centreController = UINavigationController(rootViewController: homeController)

        
        view.addSubview(centreController.view)
        addChild(centreController)
        centreController.didMove(toParent: self)
    }
    
    
    func configureMenuController(){
        if menuController == nil{
            //add menucontroler
            menuController = MenuController()
            view.insertSubview(menuController.view, at: 0)
            menuController.didMove(toParent: self)
            print("did addmenucontroller")

        }
    }
    
    
    func showMenuController (shouldExpand: Bool){
        if shouldExpand{
            //show menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centreController.view.frame.origin.x = self.centreController.view.frame.width - 100
            }, completion: nil)
            
        }else {
            // hide menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centreController.view.frame.origin.x = 0
            }, completion: nil)
        }
    }
}

extension ContainerController: HomeControllerDelegate {
    func handleMenuController() {
        if !isExpended{
            configureMenuController()
        }
        
        isExpended = !isExpended
        showMenuController(shouldExpand: isExpended)
    }
    
    
}
