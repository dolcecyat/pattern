//
//  Protocols.swift
//  task
//
//  Created by Анатолий Коробских on 10.08.2024.
//

import Foundation


protocol HomeControllerDelegate {
    func handleMenuController()
}

protocol MyTableViewCellDelegate:AnyObject {
    func didTabButton(index: Int)
}
