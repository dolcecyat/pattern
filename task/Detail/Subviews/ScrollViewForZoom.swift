//
//  ScrollViewForZoom.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 26.10.2024.
//

import Foundation
import UIKit

class ScrollViewForZoom: UIScrollView {
    
    var button: UIButton?
    
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
        self.button = button
        button.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(button)
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalTo: self.widthAnchor),
            button.heightAnchor.constraint(equalTo: self.heightAnchor),
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
extension ScrollViewForZoom: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        button
    }
}
