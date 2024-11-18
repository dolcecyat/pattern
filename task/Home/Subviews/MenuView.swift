//
//  File.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 15.08.2024.
//

import Foundation
import UIKit

private enum Constans {
    static let oopPrinciplesLabel = NSLocalizedString("menu.oopPrinciplesLabel" , comment: "Принципы ООП")
    static let designPatternsLabel = NSLocalizedString("menu.designPatternsLabel" , comment: "Паттерны проектирования")
    static let architecturalPatternsLabel = NSLocalizedString("menu.architecturalPatternsLabel" , comment: "Архитектурные паттерны")
    static let SOLIDPrinciplesLabel = NSLocalizedString("menu.SOLIDPrinciplesLabel" , comment: "Принципы SOLID")
    static let arrowRightImage = "arrow.right"
}
class MenuView: UIView {
    
    // MARK: - UI Properties
    
    let menuOptionsVStack = UIStackView()
    var oopPrinciplesHstack = UIStackView()
    var designPatternsHstack = UIStackView()
    var architecturalPatternsHstack = UIStackView()
    var SOLIDPrinciplesHstack = UIStackView()
    
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
        self.addSubview(menuOptionsVStack)
        menuOptionsVStack.addArrangedSubview(oopPrinciplesHstack)
        menuOptionsVStack.addArrangedSubview(designPatternsHstack)
        menuOptionsVStack.addArrangedSubview(architecturalPatternsHstack)
        menuOptionsVStack.addArrangedSubview(SOLIDPrinciplesHstack)
    }
    
    // MARK: - Add constraints
    
    func makeConstraints() {
        menuOptionsVStack.translatesAutoresizingMaskIntoConstraints = false
        menuOptionsVStack.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        menuOptionsVStack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        menuViewWidthConstraint = menuOptionsVStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30)
        menuViewWidthConstraint?.priority = .defaultLow
        menuViewWidthConstraint?.isActive = true
    }
    
    // MARK: - setUI
    
    func setUI() {
        menuOptionsVStack.spacing = 30
        menuOptionsVStack.axis = .vertical
        menuOptionsVStack.alignment = .leading
        
        buildHstack(stack: oopPrinciplesHstack, text: Constans.oopPrinciplesLabel)
        buildHstack(stack: designPatternsHstack, text: Constans.designPatternsLabel)
        buildHstack(stack: architecturalPatternsHstack, text: Constans.architecturalPatternsLabel)
        buildHstack(stack: SOLIDPrinciplesHstack, text: Constans.SOLIDPrinciplesLabel)
    }
    
    // MARK: - Building Hstacks
    
    func buildHstack (stack: UIStackView,text: String) {
        let image = UIImageView(image: UIImage(systemName: Constans.arrowRightImage)?.withTintColor(UIColor(.white), renderingMode: .alwaysOriginal))
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
