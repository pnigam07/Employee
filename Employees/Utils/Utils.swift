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
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
           viewController.navigationController?.popViewController(animated: true)
        })
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    private static func getAlert(withMessage message: String,
                                 title: String) -> UIAlertController {
    
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
//        switch action.style{
//        case .default:
//        print("default")
//
//        case .cancel:
//        print("cancel")
//
//        case .destructive:
//        print("destructive")
//
//        @unknown default:
//            fatalError()
//            }}))
//
        return alert
    }
    
    static func getToolBar(doneAction:Selector?, cancelAction: Selector?) -> UIToolbar{
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = Constants.ButtonTinColor
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: nil, action: doneAction)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: nil, action: cancelAction)
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.barTintColor = Constants.BarTinColor
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
}
