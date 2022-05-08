//
//  Extensions.swift
//  MyList
//
//  Created by Christopher Koski on 5/8/22.
//

import SwiftUI

extension String {
   func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
