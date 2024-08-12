//
//  MenuController.swift
//  task
//
//  Created by Анатолий Коробских on 09.08.2024.
//

import UIKit


class MenuController: UIViewController {
    
    
    // MARK: - Properties
    let reuseIdentifier = "MenuOptionCell"
    var tableView: UITableView!
    // MARK: - Init
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    // MARK: - Handlers
    
    
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MenuOptionCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.backgroundColor = .darkGray
        tableView.separatorStyle = .none
        tableView.rowHeight = 62
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
}

extension MenuController: UITableViewDelegate,  UITableViewDataSource {
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MenuOptionCell
        
        
        let menuOption = MenuOption(rawValue: indexPath.row)
        if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3  {
            cell.descriptionLabel.text = menuOption?.description
        }else {
            cell.descriptionLabel.text = menuOption?.description
            cell.iconImageView.image = UIImage(systemName: "arrow.right")!.withTintColor(UIColor(.white), renderingMode: .alwaysOriginal)
        }
        
       return cell
    }
   
    
}
