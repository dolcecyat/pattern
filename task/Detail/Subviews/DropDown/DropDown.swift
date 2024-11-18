//
//  DropDownButton.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 22.10.2024.
//

import UIKit

private enum Constants {
    static let groupString = NSLocalizedString("detail.groupString", comment: "Group")
}

protocol DropDownProtocol {
    func dropDownPressed(type:PatternsModel.PatternsCategory)
}

class DropDownButton: UIButton, DropDownProtocol {
    private let openImage = ChangeImage(image: UIImage(systemName: "arrowshape.down")?.withTintColor(UIColor(.black), renderingMode: .alwaysOriginal))
    private var changedType = PatternsModel.PatternsCategory.Поведенческие
    var currentType = PatternsModel.PatternsCategory.Поведенческие
    private var dropView = DropDownView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    private var isOpen = false
    private var height = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        dropView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard superview != nil else { return }
        superview?.addSubview(openImage)
        superview?.addSubview(dropView)
        superview?.bringSubviewToFront(dropView)
       setConstraints()
    }
    
    private func setConstraints() {
        dropView.translatesAutoresizingMaskIntoConstraints = false
        openImage.translatesAutoresizingMaskIntoConstraints = false
        
        openImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        openImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        openImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
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
            
            openImage.rotate(open: true)
        } else {
            isOpen = false
            NSLayoutConstraint.deactivate([height])
            self.height.constant = 0
            NSLayoutConstraint.activate([height])
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5,options: .curveEaseOut,animations: { [weak self] in
                self?.dropView.center.y -= (self?.dropView.frame.height ?? 0) / 2
                self?.dropView.layoutIfNeeded()
            }, completion: nil)
            openImage.rotate(open: false)
        }
    }
    
    func showOpenArrowImage(open:Bool) {
        if open {
            openImage.isHidden = false
        } else {
            openImage.isHidden = true
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
    
    func setType(){
        currentType = changedType
    }
    
    func dropDownPressed(type: PatternsModel.PatternsCategory) {
        self.setTitle((Constants.groupString + type.description), for: .normal)
        changedType = type
        dismissDropDown()
    }
}
