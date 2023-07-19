//
//  UITabBarController+extension.swift
//  All-in
//
//  Created by Daniel  Alves Barreto on 19/07/23.
//

import SwiftUI

extension UITabBarController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let standardAppearance = UITabBarAppearance()

        standardAppearance.stackedItemPositioning = .centered
        standardAppearance.stackedItemSpacing = 30
        standardAppearance.stackedItemWidth = 30

        tabBar.standardAppearance = standardAppearance
    }
}
