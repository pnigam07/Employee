//
//  Utils.swift
//  Employees
//
//  Created by pankaj on 8/14/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import UIKit

class Utils {
    static func getAlert(withMessage message: String) -> UIAlertController {
    
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        switch action.style{
        case .default:
        print("default")
        
        case .cancel:
        print("cancel")
        
        case .destructive:
        print("destructive")
    
        @unknown default:
            fatalError()
            }}))
        
        return alert
    }
}
