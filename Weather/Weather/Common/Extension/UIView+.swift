//
//  UIView+.swift
//  Weather
//
//  Created by 이조은 on 2023/10/25.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
