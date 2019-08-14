//
//  AddNewEmployeeViewController.swift
//  Employees
//
//  Created by pankaj on 8/14/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import UIKit

class AddNewEmployeeViewController: UIViewController {
    
    private lazy var cityPicker = UIPickerView()
    private lazy var marritalStatusPicker = UIPickerView()
    
    var viewState: EmployeeViewState? = nil
    private let adaptor = EditEmployeeTableViewAdaptor()
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var mariatalStatus: UILabel!
    @IBOutlet weak var mariatalStatusTextField: UITextField! {
        didSet {
            marritalStatusPicker.dataSource = self
            marritalStatusPicker.delegate = self
            mariatalStatusTextField.inputView = marritalStatusPicker
        }
    }
    
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var cityTextField: UITextField! {
        didSet {
            cityPicker.dataSource = self
            cityPicker.delegate = self
            cityTextField.inputView = cityPicker
        }
    }
    
    func isValidateData() -> Bool {
        if  nameTextField.text?.trimmingCharacters(in: .whitespaces).count ?? 0 < 6 {
            return false
        }
        if !isValidEmail(emailStr: emailTextField.text ?? "") {
            return false
        }
        if mariatalStatus.text == "" {
            return false
        }
        if cityTextField.text?.trimmingCharacters(in: .whitespaces).count ?? 0 < 4 {
            return false
        }
        
        return true
    }
    
    func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
    @objc func save() {
        if isValidateData() {
            let dict = ["name":nameTextField.text!,
                        "email":emailTextField.text!,
                        "city":cityTextField.text!,
                        "married":mariatalStatus.text!]
            let cc =  CoreDataManger()
            cc.insertEmployee(employeeDict: dict)
            self.navigationController?.popViewController(animated: true)
        }
        else {
       
            let alert = Utils.getAlert(withMessage: "Some thing is not right")
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        
        navigationItem.rightBarButtonItem = NavigationBarFactory.setupBarButton(title: "Save",
                                                                                target: self,
                                                                                action: #selector(save))
        name.text = "Name: "
        email.text = "Email: "
        mariatalStatus.text = "Married: "
        city.text = "City: "
    }
}



// MARK: UIPickerViewDelegate, UIPickerViewDataSource

extension AddNewEmployeeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == cityPicker || pickerView == marritalStatusPicker {
            return 1
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == cityPicker {
            return Constants.cityArray.count
        }
        if pickerView == marritalStatusPicker {
            return Constants.marritialStatusArray.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == cityPicker {
            return Constants.cityArray[row]
        }
        if pickerView == marritalStatusPicker {
            return Constants.marritialStatusArray[row]
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == cityPicker {
            cityTextField.text = Constants.cityArray[row]
            return
        }
        if pickerView == marritalStatusPicker {
            mariatalStatusTextField.text = Constants.marritialStatusArray[row]
            return
        }
    }
}

