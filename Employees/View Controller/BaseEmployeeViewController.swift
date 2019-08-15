//
//  BaseEmployeeViewController.swift
//  Employees
//
//  Created by pankaj on 8/15/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import Foundation
import UIKit

class BaseEmployeeViewController: UIViewController {
    
    private lazy var cityPicker = UIPickerView()
    private lazy var marritalStatusPicker = UIPickerView()
    var viewModel: UpdateViewModel
    
    var viewState: EmployeeViewState? = nil
    private var toggleRightNavigationBar = false
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var mariatalStatus: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var mariatalStatusTextField: UITextField! {
        didSet {
            marritalStatusPicker.dataSource = self
            marritalStatusPicker.delegate = self
            mariatalStatusTextField.inputView = marritalStatusPicker
            mariatalStatusTextField.inputAccessoryView = Utils.getToolBar(doneAction: #selector(doneAction(sender:)), cancelAction: #selector(cancelAction(sender:)))
        }
    }
    @IBOutlet weak var cityTextField: UITextField! {
        didSet {
            cityPicker.dataSource = self
            cityPicker.delegate = self
            cityTextField.inputView = cityPicker
            cityTextField.inputAccessoryView = Utils.getToolBar(doneAction: #selector(doneAction(sender:)), cancelAction: #selector(cancelAction(sender:)))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.viewModel = UpdateViewModel()
        super.init(coder: aDecoder)
    }
}

extension BaseEmployeeViewController {
    
    @objc func doneAction(sender: UIBarButtonItem) {
        dismissPicker()
    }
    
    @objc func cancelAction(sender: UIBarButtonItem) {
        dismissPicker()
    }
    
    private func dismissPicker()  {
        if mariatalStatusTextField.isFirstResponder {
            mariatalStatusTextField.resignFirstResponder()
        }
        else if cityTextField.isFirstResponder {
            cityTextField.resignFirstResponder()
        }
    }
}

// MARK: UIPickerViewDelegate, UIPickerViewDataSource

extension BaseEmployeeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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


