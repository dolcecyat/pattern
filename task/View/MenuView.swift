//
//  File.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 15.08.2024.
//

import Foundation
import UIKit

private enum Constans {
    static let oopPrinciplesLabel = "Принципы ООП"
    static let designPatternsLabel = "Паттерны проектирования"
    static let architecturalPatternsLabel = "Архитектурные паттерны"
    static let SOLIDPrinciplesLabel = "Принципы SOLID"
    static let arrowRightImage = "arrow.right"
}
class MenuView: UIView {
    
    // MARK: - UI Properties
    
    let Vstack = UIStackView()
    var oopPrinciplesHstack = UIStackView()
    var designPatternsHstack = UIStackView()
    var architecturalPatternsHstack = UIStackView()
    var SOLIDPrinciplesHstack = UIStackView()
    
    let oopPrinciplesLabel = Constans.oopPrinciplesLabel
    let designPatternsLabel = Constans.designPatternsLabel
    let architecturalPatternsLabel = Constans.architecturalPatternsLabel
    let SOLIDPrinciplesLabel = Constans.SOLIDPrinciplesLabel
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
        Vstack.addArrangedSubview(oopPrinciplesHstack)
        Vstack.addArrangedSubview(designPatternsHstack)
        Vstack.addArrangedSubview(architecturalPatternsHstack)
        Vstack.addArrangedSubview(SOLIDPrinciplesHstack)
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
        
        buildHstack(stack: oopPrinciplesHstack, text: Constans.oopPrinciplesLabel)
        buildHstack(stack: designPatternsHstack, text: Constans.designPatternsLabel)
        buildHstack(stack: architecturalPatternsHstack, text: Constans.architecturalPatternsLabel)
        buildHstack(stack: SOLIDPrinciplesHstack, text: Constans.SOLIDPrinciplesLabel)
    }
    
    // MARK: - Building Hstacks
    
    func buildHstack (stack: UIStackView,text: String){
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
