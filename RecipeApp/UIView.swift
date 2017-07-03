//
//  UIView.swift
//  RecipeApp
//
//  Created by Rahul Kumar on 7/2/17.
//  Copyright © 2017 Rahul Kumar. All rights reserved.
//

import Foundation
import UIKit

extension UIView
{
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.init(rawValue: 6)!)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
}
