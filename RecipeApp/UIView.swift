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
        public var cornerRadius: CGFloat {
            get { return layer.cornerRadius }
            set { layer.cornerRadius = newValue }
        }
}
