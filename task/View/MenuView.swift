//
//  File.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 15.08.2024.
//

import Foundation
import UIKit

private enum Constans {
    static let oopPrinciples = "Принципы ООП"
}
class MenuView: UIView {
    
    // MARK: - UI Properties
    
    let Vstack = UIStackView()
    var Hstack1 = UIStackView()
    var Hstack2 = UIStackView()
    var Hstack3 = UIStackView()
    var Hstack4 =  UIStackView()
    
    let label1 = "Принципы ООП"
    let label2 = "Паттерны проектирования"
    let label3 = "Архитектурные паттерны"
    let label4 = "Принципы SOLID"
    var menuViewWidthConstraint: NSLayoutConstraint?

    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        addViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Add views
    
    func addViews() {
        self.addSubview(Vstack)
        Vstack.addArrangedSubview(Hstack1)
        Vstack.addArrangedSubview(Hstack2)
        Vstack.addArrangedSubview(Hstack3)
        Vstack.addArrangedSubview(Hstack4)
    }
    
    // MARK: - Add constraints
    
    func makeConstraints() {
        Vstack.translatesAutoresizingMaskIntoConstraints = false
        Vstack.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        Vstack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        menuViewWidthConstraint = Vstack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30)
        menuViewWidthConstraint?.priority = .defaultLow
        menuViewWidthConstraint?.isActive = true
    }
    
    // MARK: - setUI
    
    func setUI() {
        Vstack.spacing = 30
        Vstack.axis = .vertical
        Vstack.alignment = .leading
        
        buildHstack(stack: Hstack1, text: Constans.oopPrinciples)
        buildHstack(stack: Hstack2, text: label2)
        buildHstack(stack: Hstack3, text: label3)
        buildHstack(stack: Hstack4, text: label4)
    }
    
    // MARK: - Building Hstacks
    
    func buildHstack (stack: UIStackView,text: String){
        let image = UIImageView(image: UIImage(systemName: "arrow.right")!.withTintColor(UIColor(.white), renderingMode: .alwaysOriginal))
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        stack.addArrangedSubview(image)
        stack.addArrangedSubview(label)
        stack.spacing = 6
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
    }
}
