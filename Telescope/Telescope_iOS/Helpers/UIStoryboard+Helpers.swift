//
//  UIStoryboard+Helpers.swift
//  Telescope
//
//  Created by Todd Olsen on 1/11/17.
//
//

import UIKit

extension UIStoryboard {

    public static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }

    public func instantiate<A: UIViewController>(_ type: A.Type) -> A {
        guard let vc = self.instantiateViewController(withIdentifier: String(describing: type.self)) as? A else {
            fatalError("Could not instantiate view controller \(A.self)") }
        return vc
    }

    public func instantiateNavigationController(withIdentifier identifier: String) -> UINavigationController {
        guard let nav = instantiateViewController(withIdentifier: identifier) as? UINavigationController else { fatalError("Could not create a navigation controller with identifier \(identifier).") }
        return nav
    }
    
}
