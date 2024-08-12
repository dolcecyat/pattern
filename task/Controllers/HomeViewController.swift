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
    let numbers = ["1","2","3"]
    var presenter: HomePresentationProtocol?
    var delegate: HomeControllerDelegate?
    
    //MARK: - UI properties
    let homeTableViewCell = "HomeTableViewCell"
    var tableView: UITableView!
    let groupNames = ["Поведенческие","Порождающие","Структурные"]

    
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
//        setupNavBar()
        addViews()
        makeConstraints()
        setupViews()
        setupAction()
        view.backgroundColor = .white
    }
    
    //MARK: - objc method
}

private extension HomeViewController {
    
    //MARK: - addViews
    
    func addViews() {
        configureHomeTableView()
    }
    
    //MARK: - makeConstraints
    
    func makeConstraints() {
        
    }
    
    //MARK: - setupViews
    
    func setupViews() {
        setupNavBar()
    }
    
    func configureHomeTableView() {
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: homeTableViewCell)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.allowsMultipleSelection = true
        tableView.separatorInset.bottom = 10
        tableView.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }

    
    //MARK: - setupNavBar
    
    @objc func handleMenuToggle() {
        delegate?.handleMenuController()
    }
    @objc func addButtonToggle() {
        
    }
    
    func setupNavBar() {
      
        self.navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barStyle = .black
    
        navigationItem.title = "Паттерны проектирования"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet")?.withTintColor(UIColor(.black), renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus")?.withTintColor(UIColor(.black), renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(addButtonToggle))
        
    }
    
    //MARK: - setupAction
    
    func setupAction() {
        
    }
}
extension HomeViewController: UITableViewDelegate,  UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 113
    
    }
    
    func tableView(_ tableView: UITableView,trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { /*[self]*/(action, sourceView, completionHandler) in
//             let deleteItem = patterns[indexPath.row]
        }
         tableView.reloadData()
         let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeConfiguration
        
        }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groupNames[section]
        }
        
        
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
            return 30
        }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return numbers.count
        }
        
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 3
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: homeTableViewCell, for: indexPath) as! HomeTableViewCell
            return cell
        }
    }

extension HomeViewController: MyTableViewCellDelegate{
    func didTabButton(index: Int) {
    }
}
