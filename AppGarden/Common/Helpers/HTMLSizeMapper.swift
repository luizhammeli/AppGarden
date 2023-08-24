//
//  HTMLSizeMapper.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 24/08/23.
//

import Foundation

struct HTMLSizeMapper {
    static func map(description: String, thresholdValue: CGFloat = 240) -> CGSize {
        let str = description.replacingOccurrences(of: "\"", with: String(), options: .regularExpression, range: nil)
        
        var query = String()
        var strHeight = String()
        var strWidth = String()
        
        for char in str {
            let str = String(char)
            if str == " " {
                query.removeAll()
                continue
            }
            
            if query == "width=" {
                strWidth += str
            } else if query == "height=" {
                strHeight += str
            } else {
                query.append(str)
            }
        }
        
        if let height = Int(strHeight), let width = Int(strWidth) {
            let finalWidth = min(CGFloat(integerLiteral: width), thresholdValue)
            let finalHeight = min(CGFloat(integerLiteral: height), thresholdValue)
            return CGSize(width: finalWidth, height: finalHeight)
        }
        
        return CGSize(width: thresholdValue, height: thresholdValue)
    }
}
