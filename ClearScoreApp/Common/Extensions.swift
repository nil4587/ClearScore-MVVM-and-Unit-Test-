//
//  Extensions.swift
//  ClearScoreApp
//
//  Created by Nileshkumar Mukeshbhai Prajapati on 2021/10/05.
//

import Foundation
import UIKit

// MARK: - ================================
// MARK: String
// MARK: ================================

extension String {
    var trimmedString: String { return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) }
    
    var length: Int { return self.count }
    
    /**
     To map the string with localised synonym.
     */
    func localised() -> String {
        return NSLocalizedString(self, comment: "")
    }
}

// MARK: - ================================
// MARK: UINavigationBar
// MARK: ================================

extension UINavigationBar {
    
    static func updateNavigationBarProperties() {
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}


// MARK: - ================================
// MARK: UIView
// MARK: ================================

extension UIView {
    
    var width: CGFloat { get { return self.frame.size.width } set { self.frame.size.width = newValue } }
    
    func addBorderAndShadow(offset: CGSize,
                            borderColor: UIColor,
                            borderRadius: CGFloat,
                            shadowColor: UIColor,
                            shadowRadius: CGFloat,
                            opacity: Float) {
        layer.cornerRadius = borderRadius
        layer.borderColor = borderColor.cgColor
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = shadowColor.cgColor
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = opacity
    }
}
