//
//  UIColor+Extension.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 25.09.21.
//

import Foundation
import UIKit

extension UIColor{
    static let textBlue = UIColor.rgb(r: 66, g: 118, b: 165)
    static let backGrey = UIColor.rgb(r: 238, g: 238, b: 238)
    static let backDarkGrey = UIColor.rgb(r: 230, g: 230, b: 230)
    static let malina = UIColor.rgb(r: 121, g: 21, b:76)

    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

//@available(iOS 13.0, *)
//extension CGColor{
//    static let textBlue = CGColor.rgb(r: 66, g: 118, b: 165)
//    static let backGrey = CGColor.rgb(r: 238, g: 238, b: 238)
//    static let backDarkGrey = CGColor.rgb(r: 230, g: 230, b: 230)
//    static let malina = UIColor.rgb(r: 121, g: 21, b:76)
//
//    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> CGColor {
//        return CGColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
//    }
//}
