//
//  UIView+Helpers.swift
//  Telescope
//
//  Created by Todd Olsen on 1/11/17.
//
//

import UIKit

extension UIView {

    public func constrain(subview: UIView) {
        subview.frame = frame
        subview.translatesAutoresizingMaskIntoConstraints = false
        if !subviews.contains(subview) {
            addSubview(subview)
        }
        topAnchor.constraint(equalTo: subview.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: subview.bottomAnchor).isActive = true
        leftAnchor.constraint(equalTo: subview.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: subview.rightAnchor).isActive = true
    }

}
