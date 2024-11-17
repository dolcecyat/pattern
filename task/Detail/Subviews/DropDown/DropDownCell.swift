//
//  File.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 15.11.2024.
//

import Foundation
import UIKit

class DropDownCell: UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    private var label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addView()
        setupUI()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView() {
        self.addSubview(label)
    }
    
    func setTitle(title: String) {
        label.text = title
    }
    private func setupUI() {
        self.backgroundColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
    }
}

