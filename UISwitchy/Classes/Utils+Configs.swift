//
//  Utils.swift
//  UISwitchy
//
//  Created by Omar on 12/27/20.
//

import UIKit
public extension UIImageView {
    func tintImage(withColor color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color

    }
}

extension UIView {
    func setCircle() {
        self.clipsToBounds = true
        self.layer.cornerRadius = bounds.height / 2
        self.layer.masksToBounds = true
    }
}

extension UIView {
    func hide() {
        guard isHidden == false else { return }
        isHidden = true
    }
    func reveal() {
        guard isHidden else { return }
        isHidden = false
    }
}
