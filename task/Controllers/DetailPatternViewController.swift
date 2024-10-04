//
//  DetailPatternViewController.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 03.10.2024.
//


import UIKit

protocol DetailPatternDisplayLogic: UIViewController {
    var router: HomeRouterProtocol? {get set}
}

class DetailPatternViewController: UIViewController, DetailPatternDisplayLogic  {
    var router: (any HomeRouterProtocol)?
    
    
    //MARK: - MVP Properties
    

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
    }
    
    //MARK: - objc method
}

private extension DetailPatternViewController {
    
    //MARK: - addViews
    
    func addViews() {
        
    }
    
    //MARK: - makeConstraints
    
    func makeConstraints() {
        
    }
    
    //MARK: - setupViews
    
    func setupViews() {
        setupNavBar()
    }
    
    //MARK: - setupNavBar
    
    func setupNavBar() {
        
    }
    
    //MARK: - setupAction
    
    func setupAction() {
        
    }
}
