//
//  ScrollViewForZoom.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 26.10.2024.
//

import Foundation
import UIKit

class ScrollViewForZoom: UIScrollView {
    
    var buttonIn: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUp() {
        self.delegate = self
        self.minimumZoomScale = 1
        self.maximumZoomScale = 3
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
    }
    
    func setUpButton(_ button: UIButton) {
        self.buttonIn = button
        if let buttonIn {
            buttonIn.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(buttonIn)
            NSLayoutConstraint.activate([
                buttonIn.widthAnchor.constraint(equalTo: self.widthAnchor),
                buttonIn.heightAnchor.constraint(equalTo: self.heightAnchor),
                buttonIn.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                buttonIn.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])}
    }
}
extension ScrollViewForZoom: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        buttonIn
    }
}
