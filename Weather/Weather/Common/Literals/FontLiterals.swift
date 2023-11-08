//
//  FontLiterals.swift
//  Weather
//
//  Created by 이조은 on 2023/10/25.
//

import UIKit

//struct FontName {
//    static let SFProDisplayBold = "SFProDisplay-Bold"
//    static let SFProDisplayLight = "SFProDisplay-Light"
//    static let SFProDisplayMedium = "SFProDisplay-Medium"
//    static let SFProDisplayRegular = "SFProDisplay-Regular"
//    static let SFProDisplayThin = "SFProDisplay-Thin"
//}

extension UIFont {
    static func SFPro(size fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        let familyName = "SFProDisplay"

        var weightString: String
        switch weight {
        case .bold:
            weightString = "Blod"
        case .light:
            weightString = "Light"
        case .medium:
            weightString = "Medium"
        case .regular:
            weightString = "Regular"
        case .thin:
            weightString = "Thin"
        default:
            weightString = "Regular"
        }

        return UIFont(name: "\(familyName)-\(weightString)", size: fontSize) ?? .systemFont(ofSize: fontSize, weight: weight)
    }
}
