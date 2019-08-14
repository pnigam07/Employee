//
//  EditEmployeeViewController.swift
//  Employees
//
//  Created by pankaj on 8/13/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import UIKit

class EmployeeDetailViewController: UIViewController {
    
    private lazy var cityPicker = UIPickerView()
    private lazy var marritalStatusPicker = UIPickerView()
    
    var viewState: EmployeeViewState? = nil
 
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var mariatalStatus: UILabel!
    @IBOutlet weak var mariatalStatusTextField: UITextField!

    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var cityTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.title = "Employe Detail"
        setUpView()
    }
    
    func setUpView() {
        
        name.text = "Name: "
        email.text = "Email: "
        mariatalStatus.text = "Married: "
        city.text = "City: "
        
        nameTextField.text = viewState?.name
        emailTextField.text = viewState?.email
        mariatalStatusTextField.text = viewState?.married
        cityTextField.text = viewState?.city
        
        nameTextField.isUserInteractionEnabled = false
        emailTextField.isUserInteractionEnabled = false
        mariatalStatusTextField.isUserInteractionEnabled = false
        cityTextField.isUserInteractionEnabled = false
        
    }
}

// MARK: UIPickerViewDelegate, UIPickerViewDataSource

extension EmployeeDetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
