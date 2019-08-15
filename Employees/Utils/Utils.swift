//
//  Utils.swift
//  Employees
//
//  Created by pankaj on 8/14/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import UIKit

class Utils {
    
    static func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
    static func showAlert(message: String, title: String, viewController: UIViewController){
        let alert = Utils.getAlert(withMessage: message, title: title)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func getAlert(withMessage message: String, title: String) -> UIAlertController {
    
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
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
