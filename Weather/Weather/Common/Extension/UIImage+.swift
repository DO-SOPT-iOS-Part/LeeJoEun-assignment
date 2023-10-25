//
//  UIImage+.swift
//  Weather
//
//  Created by 이조은 on 2023/10/25.
//

import UIKit

extension UIImage {

    static func load(name: String) -> UIImage {
        guard let image = UIImage(named: name, in: nil, compatibleWith: nil) else {
            return UIImage()
        }
        image.accessibilityIdentifier = name
        return image
    }
}
