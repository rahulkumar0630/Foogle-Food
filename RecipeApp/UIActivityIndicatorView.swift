//
//  UIActivityIndicatorView.swift
//  RecipeApp
//
//  Created by Rahul Kumar on 6/25/17.
//  Copyright © 2017 Rahul Kumar. All rights reserved.
//

import Foundation
import UIKit

extension UIActivityIndicatorView {
    func scale(factor: CGFloat) {
        guard factor > 0.0 else { return }
        
        transform = CGAffineTransform(scaleX: factor, y: factor)
    }
}
