//
//  DetailPatternViewController.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 03.10.2024.
//


import UIKit

private enum Constants {
    static let redHeartImage = "redHeart"
    static let greyHeartImage = "greyHeart"
    static let groupString = "Группа:\n"
    static let editBarButtonImageName = "rectangle.and.pencil.and.ellipsis.rtl"
    static let defaultImage = UIImage(named: "abstract-factory")
}

protocol DetailPatternDisplayLogic: UIViewController {
    var router: HomeRouterProtocol? {get set}
}

class DetailPatternViewController: UIViewController, DetailPatternDisplayLogic  {
    var router: (any HomeRouterProtocol)?
    
    
    //MARK: - Data Properties
    var model: PatternsModel = PatternsModel( patternImage: UIImage(resource: .abstractFactory),
                                              patternName: "",
                                              patternDescription: "",
                                              category: PatternsModel.PatternsCategory.Поведенческие,
                                              isFavorite: false,
                                              numberOfViews: 0)
    
    //MARK: - UI properties
    
    let patternImage = UIImageView()
    let favoriteImage = UIImageView()
    let patternDescriptionLabel = UILabel()
    let patternNameLabel = UILabel()
    let patternTypeLabel = UILabel()
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    //MARK: - View lifecycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
        addViews()
        makeConstraints()
        setupViews()
        setupAction()
    }
}
    //MARK: - objc method

private extension DetailPatternViewController {

    //MARK: - addViews
    
    func addViews() {
        view.addSubview(patternNameLabel)
        view.addSubview(patternTypeLabel)
        view.addSubview(patternDescriptionLabel)
        view.addSubview(patternImage)
        view.addSubview(favoriteImage)
    }
    
    //MARK: - makeConstraints
    
    func makeConstraints() {
        patternImage.translatesAutoresizingMaskIntoConstraints = false
        patternTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        patternNameLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteImage.translatesAutoresizingMaskIntoConstraints = false
        patternDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        patternImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
        patternImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
        patternImage.heightAnchor.constraint(equalToConstant: 200),
        patternImage.widthAnchor.constraint(equalToConstant: 310),
        
        patternNameLabel.topAnchor.constraint(equalTo: patternImage.bottomAnchor, constant: 40),
        patternNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
        
        patternTypeLabel.topAnchor.constraint(equalTo: patternNameLabel.bottomAnchor, constant: 20),
        patternTypeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
//        patternTypeLabel.widthAnchor.constraint(equalToConstant: 180),
        
        patternDescriptionLabel.topAnchor.constraint(equalTo: patternTypeLabel.bottomAnchor, constant: 20),
        patternDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
        patternDescriptionLabel.widthAnchor.constraint(equalToConstant: 330),
        
        favoriteImage.topAnchor.constraint(equalTo: patternImage.bottomAnchor, constant: 48),
        favoriteImage.leadingAnchor.constraint(equalTo: patternNameLabel.trailingAnchor,constant: 10),
        favoriteImage.heightAnchor.constraint(equalToConstant: 18),
        favoriteImage.widthAnchor.constraint(equalToConstant: 18)])
    }
    
    //MARK: - setupViews
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.editBarButtonImageName)!.withTintColor(UIColor(.black), renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(edit))
        
        patternImage.image = model.patternImage
        patternImage.contentMode = .scaleAspectFit
        patternImage.backgroundColor = .white
        patternImage.layer.cornerRadius = 10
        patternImage.layer.shadowColor = UIColor.gray.cgColor
        patternImage.layer.shadowOpacity = 0.9
        patternImage.layer.shadowOffset = CGSize(width: 1, height: 1)
        patternImage.layer.shadowRadius = 5

        patternDescriptionLabel.textColor = .lightGray
        patternDescriptionLabel.textAlignment = .left
        patternDescriptionLabel.font = .systemFont(ofSize: 22)
        patternDescriptionLabel.text = capitalizingFirstLetter(model.patternDescription)
        patternDescriptionLabel.numberOfLines = 10
        
        patternNameLabel.textAlignment = .left
        patternNameLabel.font = .systemFont(ofSize: 28)
        patternNameLabel.text = model.patternName
       
        patternTypeLabel.text = Constants.groupString + model.category.description
        patternTypeLabel.font = .systemFont(ofSize: 24)
        patternTypeLabel.textAlignment = .left
        patternTypeLabel.numberOfLines = 2
        
        favoriteImage.image = model.isFavorite ? UIImage(named: Constants.redHeartImage) : nil
    }
    
    //MARK: - setupAction
    @objc func edit() {
        print("EDITING")
    }
    func setupAction() {
        
    }
   // MARK: - Capitalising
    func capitalizingFirstLetter(_ string:String) -> String {
            let first = string.prefix(1).capitalized
            let other = string.dropFirst()
            return first + other
        }
}
