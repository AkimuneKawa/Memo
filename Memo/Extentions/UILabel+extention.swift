//
//  UILabel+extention.swift
//  Memo
//
//  Created by 河明宗 on 2019/04/02.
//  Copyright © 2019 Akimune Kawa. All rights reserved.
//

import Foundation
import UIKit
import Then

extension UILabel {
    func apply(size: CGFloat, weight: UIFont.Weight, color:UIColor = .black) {
        UIFont.systemFont(ofSize: size, weight: weight)
        textColor = color
    }
    
    static func labelHeight(
        text: String,
        width: CGFloat,
        size: CGFloat,
        weight: UIFont.Weight,
        numberOfLines: Int
    ) -> CGFloat {
        return UILabel().then {
            $0.frame = CGRect(x: 0,y: 0, width: width, height: UIScreen.main.bounds.width)
            $0.apply(size: size, weight: weight)
            $0.numberOfLines = numberOfLines
            $0.text = text
            $0.sizeToFit()
        }.bounds.height
    }
    
    static func oneLineLabelHeight(size: CGFloat, weight: UIFont.Weight) -> CGFloat {
        return UILabel.labelHeight(
            text: "Test",
            width: UIScreen.main.bounds.width,
            size: size,
            weight: weight,
            numberOfLines: 1
        )
    }
}
