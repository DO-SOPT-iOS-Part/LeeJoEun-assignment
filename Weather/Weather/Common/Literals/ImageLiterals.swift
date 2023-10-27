//
//  ImageLiterals.swift
//  Weather
//
//  Created by 이조은 on 2023/10/25.
//

import UIKit

enum ImageLiterals {
    enum Common {
    }

    enum Main {
        static var ic_more: UIImage { .load(name: "ic_more") }
        static var img_cardBG: UIImage { .load(name: "img_cardBG") }
    }

    enum Detail {
        static var img_detailBG: UIImage { .load(name: "img_detailBG") }
        static var ic_dot: UIImage { .load(name: "ic_dot") }
        static var ic_map: UIImage { .load(name: "ic_map") }
        static var ic_list: UIImage { .load(name: "ic_list") }
        static var ic_paperplane: UIImage { .load(name: "ic_paperplane") }
    }
}
