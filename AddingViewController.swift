//
//  AddingViewController.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 06.10.2024.
//


import UIKit

protocol AddingDisplayLogic: UIViewController {
    var router: HomeRouterProtocol? {get set}
}


class AddingViewController: UIViewController, AddingDisplayLogic {
    
    //MARK: - MVP Properties
    
    var router: (any HomeRouterProtocol)?
    
    //MARK: - UI properties

    
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
  
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setup()
        
    }
    
    // MARK: - Setup
    
    private func setup() {
    }
  
    //MARK: - View lifecycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
        addViews()
        makeConstraints()
        setupViews()
        setupAction()
        view.backgroundColor = .blue
    }
    
    //MARK: - objc method
}

private extension AddingViewController {
    
    //MARK: - addViews
    
    func addViews() {
        
    }
    
    //MARK: - makeConstraints
    
    func makeConstraints() {
        
    }
    
    //MARK: - setupViews
    
    func setupViews() {
      
    }
    
    //MARK: - setupAction
    
    func setupAction() {
        
    }
}
