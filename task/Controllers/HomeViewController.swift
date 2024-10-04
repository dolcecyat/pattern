//
//  HomeViewController.swift
//  task
//
//  Created by Анатолий Коробских on 09.08.2024.
//

import UIKit

private enum Constants {
    static let deleteSwipeAction = "Удалить"
    static let plusImage = "plus"
    static let listBlletImage = "list.bullet"
    static let designPattensTitleForNavigationBar = "Паттерны проектирования"
    static let separatorInsertForBottomTableView = 10.0
    static let durationForShowMenuView = 0.5
}

protocol HomeDisplayLogic: UIViewController {
    var presenter: HomePresentationProtocol? {get set}
    func updateData()
}

class HomeViewController: UIViewController, HomeDisplayLogic {
    //MARK: - MVP Properties
    
    var presenter: HomePresentationProtocol?
    
    //MARK: - UI properties
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    var menuView = MenuView()
    var menuViewWidthConstraint: NSLayoutConstraint?
    
    // MARK: - Data Properties
    
    private var shouldExpanding = true
    
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
        setup()
        filterPatterns()
        addViews()
        setupViews()
        makeConstraints()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let assembly = HomeAssembly()
        assembly.configurate(self)
    }
}

private extension HomeViewController {
    //MARK: - addViews
    
    private func addViews() {
        view.addSubview(tableView)
        navigationController?.view.addSubview(menuView)
    }
    
    //MARK: - makeConstraints
    
    private func makeConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        guard let navView = navigationController?.view else { return }
        
        menuView.translatesAutoresizingMaskIntoConstraints = false
        menuView.bottomAnchor.constraint(equalTo: navView.bottomAnchor).isActive = true
        menuView.topAnchor.constraint(equalTo: navView.topAnchor).isActive = true
        menuView.leftAnchor.constraint(equalTo: navView.leftAnchor).isActive = true
        menuViewWidthConstraint = menuView.widthAnchor.constraint(equalToConstant: 0)
        menuViewWidthConstraint?.isActive = true
    }
    
    //MARK: - setupViews
    
    private func setupViews(){
        setupNavBar()
        configureHomeTableView()
        menuView.backgroundColor = .darkGray
        menuView.layer.zPosition = 1
    }
    // MARK: - TableView configuration
    
    private func configureHomeTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.allowsMultipleSelection = true
        tableView.separatorInset.bottom = Constants.separatorInsertForBottomTableView
    }
    
    func filterPatterns () {
        presenter?.filteredPatterns(group: PatternsModel.PatternsCategory.Структурные)
        presenter?.filteredPatterns(group: PatternsModel.PatternsCategory.Порождающие)
        presenter?.filteredPatterns(group: PatternsModel.PatternsCategory.Поведенческие)
    }
    
    //MARK: - setupNavBar
    
    private func setupNavBar() {
        self.navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.title = Constants.designPattensTitleForNavigationBar
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.plusImage)?.withTintColor(UIColor(.black), renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(addButton))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.listBlletImage)?.withTintColor(UIColor(.black), renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
    }
    
    //MARK: - navigationBar Actions
    
    @objc private func handleMenuToggle() {
        self.menuViewWidthConstraint?.isActive = false
        if shouldExpanding == true {
            // Активируем новые констрейнты для появления меню
            menuViewWidthConstraint = menuView.widthAnchor.constraint(equalTo: view.widthAnchor, constant:  -100)
            menuViewWidthConstraint?.isActive = true
        } else {
            // Активируем новые констрейнты для скрытия меню
            menuViewWidthConstraint = menuView.widthAnchor.constraint(equalToConstant: .zero)
            menuViewWidthConstraint?.isActive = true
        }
        UIView.animate(withDuration: Constants.durationForShowMenuView) {
            self.navigationController?.view.layoutIfNeeded()
        }
        self.shouldExpanding.toggle()
    }
    
    @objc private func addButton() {
    }
}
    // MARK: - UITableViewDelegate,  UITableViewDataSource

extension HomeViewController: UITableViewDelegate,  UITableViewDataSource {
    
    func updateData() {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectPatternForDetails(indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.openPatternDetails(patternAtIndexPath: indexPath)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView,trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
        let deleteAction = UIContextualAction(style: .destructive, title: Constants.deleteSwipeAction) { [self] (action, sourceView, completionHandler) in
            presenter?.deletePattern(indexPath: indexPath)
            tableView.reloadData()
        }
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeConfiguration
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        presenter?.getSectionName(section: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter?.getNumberOfSections() ?? .zero
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowsInSection = presenter?.countCells(section: section) ?? .zero
        return rowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell,
              let model = presenter?.cellInformation(indexPath: indexPath) else {return UITableViewCell() }
        cell.configure(model: model)
        cell.clousure = { [weak self] isFavorite in
            guard let self = self else {return}
            self.presenter?.addingPatternToFavorite(IndexPath: indexPath, isFavorite: isFavorite)
        }
        return cell
    }
}
