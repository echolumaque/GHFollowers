//
//  UITableView+Extenson.swift
//  GHFollowers
//
//  Created by Echo Lumaque on 2/20/25.
//

import UIKit

extension UITableView {
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
    
}
