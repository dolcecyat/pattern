//
//  DropDownView.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 15.11.2024.
//

import Foundation
import UIKit

class DropDownView: UIView {
    
    var tableView = UITableView()
    var delegate: DropDownProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DropDownCell.self, forCellReuseIdentifier: DropDownCell.identifier)
    }
    
    private func setConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
}

extension DropDownView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        PatternsModel.PatternsCategory.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DropDownCell.identifier, for: indexPath) as? DropDownCell, let title = PatternsModel.PatternsCategory.allCases.first(where: { $0.sectionNumber == indexPath.row})?.description  else { return UITableViewCell() }
        cell.setTitle(title:title)
        return cell 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gat = PatternsModel.PatternsCategory.allCases.first { $0.sectionNumber == indexPath.row }
        guard let newCategory = gat else {return}
        delegate?.dropDownPressed(type: newCategory)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

