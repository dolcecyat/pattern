//
//  HomeViewController.swift
//  task
//
//  Created by Анатолий Коробских on 09.08.2024.
//


import UIKit

protocol HomeDisplayLogic: UIViewController {
    var presenter: HomePresentationProtocol? {get set}
}

class HomeViewController: UIViewController, HomeDisplayLogic {
    
    //MARK: - MVP Properties

    var presenter: HomePresentationProtocol?
    
    //MARK: - UI properties
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    var menuView = MenuView()
    var menuViewLeftConstraint: NSLayoutConstraint?
    var menuViewRightConstraint: NSLayoutConstraint?
    
    // MARK: - Data Properties
    
    private var shouldExpanding = true
    let homeTableViewCell = "HomeTableViewCell"
    private let groupNames = ["Поведенческие","Порождающие","Структурные"]

    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
  
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }

    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupViews()
        makeConstraints()
      
    }
}

private extension HomeViewController {
    
    //MARK: - addViews
    
    private func addViews() {
        
        view.addSubview(tableView)
        view.addSubview(menuView)
    }
    
    //MARK: - makeConstraints
    
    private func makeConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        menuView.translatesAutoresizingMaskIntoConstraints = false
        menuViewLeftConstraint = menuView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -view.frame.width)
        menuViewRightConstraint = menuView.rightAnchor.constraint(equalTo: view.leftAnchor)
        menuViewLeftConstraint?.isActive = true
        menuViewRightConstraint?.isActive = true

        menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        menuView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
    }
    
    //MARK: - setupViews
    
    private func setupViews() {
        setupNavBar()
        configureHomeTableView()
        menuView.backgroundColor = .darkGray
//        menuView.isHidden = shouldExpanding
    }
    
    private func configureHomeTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: homeTableViewCell)
        
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.allowsMultipleSelection = true
        tableView.separatorInset.bottom = 10
    }
    
    //MARK: - setupNavBar
    
    func setupNavBar() {
        self.navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.title = "Паттерны проектирования"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus")?.withTintColor(UIColor(.black), renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(addButtonToggle))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet")?.withTintColor(UIColor(.black), renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
    }
    
    //MARK: - navigationBar Actions
    
    @objc private func handleMenuToggle() {
        self.menuViewLeftConstraint?.isActive = false
        self.menuViewRightConstraint?.isActive = false
        if shouldExpanding == true {
            // Активируем новые констрейнты для появления меню
            menuViewLeftConstraint = menuView.leftAnchor.constraint(equalTo: view.leftAnchor)
            menuViewRightConstraint = menuView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100)
            menuViewLeftConstraint?.isActive = true
            menuViewRightConstraint?.isActive = true
            
        }else {
            menuViewLeftConstraint = menuView.leftAnchor.constraint(equalTo: view.leftAnchor)
            menuViewRightConstraint = menuView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -500)
            menuViewLeftConstraint?.isActive = true
            menuViewRightConstraint?.isActive = true
        }
                
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.menuView.layoutIfNeeded()
        }

        self.shouldExpanding = !self.shouldExpanding
//        menuView.isHidden = shouldExpanding
    }
    
    @objc private func addButtonToggle() {
    }
}
    // MARK: - UITableViewDelegate,  UITableViewDataSource

extension HomeViewController: UITableViewDelegate,  UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         113
    }
    
    func tableView(_ tableView: UITableView,trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { /*[self]*/(action, sourceView, completionHandler) in
        }
         tableView.reloadData()
         let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeConfiguration
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         groupNames[section]
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
         30
    }

    func numberOfSections(in tableView: UITableView) -> Int {
         3
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: homeTableViewCell, for: indexPath) as? HomeTableViewCell else {return UITableViewCell() }
            return cell
        }
    }
