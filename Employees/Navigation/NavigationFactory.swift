//
//  NavigationFactory.swift
//  Employee
//
//  Created by pankaj on 8/12/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import UIKit

class NavigationBarFactory: NSObject {
    
    static func setupBarButton(title: String,
                               target: Any?,
                               action: Selector?,
                               renderingMode: UIImage.RenderingMode = .automatic) -> UIBarButtonItem {
        let barButton = UIBarButtonItem(
            title: title,
            style: .plain,
            target: target,
            action: action
        )
        return barButton
    }
    
    static func setupSystemBarButton(with type: UIBarButtonItem.SystemItem,
                                     target: Any?,
                                     action: Selector?) -> UIBarButtonItem {
        let barButton = UIBarButtonItem(barButtonSystemItem: type,
                                        target: target,
                                        action: action)
        return barButton
    }
    
    static func setuBackBarButtonWithTitle(title:String) -> UIBarButtonItem {
        let barButton = UIBarButtonItem(
            title: title,
            style: .plain,
            target: nil,
            action: nil)
        return barButton
    }
}

