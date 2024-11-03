//
//  DropDownButton.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 22.10.2024.
//

import UIKit

private enum Constants {
    static let groupString = "Группа: "
}

protocol DropDownProtocol {
    func dropDownPressed(type:PatternsModel.PatternsCategory)
}

class DropDownButton: UIButton, DropDownProtocol {
    
    var currentType = PatternsModel.PatternsCategory.Поведенческие
    var dropView = DropDownView()
    var isOpen = false
    var height = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        dropView = DropDownView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        dropView.delegate = self
        
        dropView.translatesAutoresizingMaskIntoConstraints = false
        superview?.addSubview(dropView)
        superview?.bringSubviewToFront(dropView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard superview != nil else { return }
        superview?.addSubview(dropView)
        superview?.bringSubviewToFront(dropView)
        
        dropView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        dropView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dropView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        height = dropView.heightAnchor.constraint(equalToConstant: 0)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if isOpen == false{
            isOpen = true
            NSLayoutConstraint.deactivate([height])
            self.height.constant = 100
            NSLayoutConstraint.activate([height])
            UIView.animate(withDuration: 0.5, 
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0.5,
                           options: .curveEaseOut,
                           animations: { [weak self] in
                self?.dropView.layoutIfNeeded()
                self?.dropView.center.y += (self?.dropView.frame.height ?? 0) / 2},
                           completion: nil)
        }else {
            isOpen = false
            NSLayoutConstraint.deactivate([height])
            self.height.constant = 0
            NSLayoutConstraint.activate([height])
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5,options: .curveEaseOut,animations: { [weak self] in
                self?.dropView.center.y -= (self?.dropView.frame.height ?? 0) / 2
                self?.dropView.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    func dismissDropDown() {
        isOpen = false
        NSLayoutConstraint.deactivate([height])
        height.constant = 0
        NSLayoutConstraint.activate([height])
        UIView.animate(withDuration: 0.5, 
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseOut,
                       animations: { [weak self] in
            self?.dropView.center.y -= (self?.dropView.frame.height ?? 0) / 2
            self?.dropView.layoutIfNeeded()},
                       completion: nil)
    }
    
    func dropDownPressed(type: PatternsModel.PatternsCategory) {
        self.setTitle((Constants.groupString + type.description), for: .normal)
        currentType = type
        dismissDropDown()
    }
}

class DropDownView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var tableView = UITableView()
    var delegate: DropDownProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DropDownCell.self, forCellReuseIdentifier: DropDownCell.identifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        PatternsModel.PatternsCategory.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DropDownCell.identifier, for: indexPath) as? DropDownCell else { return UITableViewCell() }
        cell.label.text = PatternsModel.PatternsCategory.allCases.first(where: { $0.sectionNumber == indexPath.row})?.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gat = PatternsModel.PatternsCategory.allCases.first { $0.sectionNumber == indexPath.row }
        guard let newCategory = gat else {return}
        delegate?.dropDownPressed(type: newCategory)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

class DropDownCell: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    var label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addView()
        setupUI()
        self.backgroundColor = .systemGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView() {
        self.addSubview(label)
    }
    
    func setupUI() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
    }
}
