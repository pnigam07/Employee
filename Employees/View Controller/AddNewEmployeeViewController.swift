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
    private var viewModel: AddNewEmployeeViewModel
    
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
    
    required init?(coder aDecoder: NSCoder) {
        self.viewModel = AddNewEmployeeViewModel()
        super.init(coder: aDecoder)
    }
    
    func isValidateData() -> Bool {
        if  nameTextField.text?.trimmingCharacters(in: .whitespaces).count ?? 0 < 6 {
            return false
        }
        if !Utils.isValidEmail(emailStr: emailTextField.text ?? "") {
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
    
    override func viewDidLoad() {
        setupNavigation()
        setUpView()
        self.viewModel.delegate = self
    }
    
    func setupNavigation(){
        self.title = "Add Employee"
        navigationItem.rightBarButtonItem = NavigationBarFactory.setupBarButton(title: "Save",
                                                                                target: self,
                                                                                action: #selector(save))
    }
    
    func setUpView(){
        name.text = "Name: "
        email.text = "Email: "
        mariatalStatus.text = "Married: "
        city.text = "City: "
        mariatalStatusTextField.text = Constants.marritialStatusArray.first
        cityTextField.text = Constants.cityArray.first
    }
    
    func popViewController()  {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func save() {
        
       let empViewState = EmployeeViewState(name: nameTextField.text?.trimmingCharacters(in: .whitespaces) ?? "",
                                            email: emailTextField.text?.trimmingCharacters(in: .whitespaces) ?? "",
                                            city: cityTextField.text?.trimmingCharacters(in: .whitespaces) ?? "",
                                            married: mariatalStatusTextField.text?.trimmingCharacters(in: .whitespaces) ?? "")
        self.viewModel.save(viewState: empViewState)
    }
}

extension AddNewEmployeeViewController: NewEmployeeDelegate {
    func recordUpdateStatus(result: Result<String, Error>) {
        switch result {
        case .success(_):
            popViewController()
        case .failure(let error):
            print(error)
            let alert = Utils.getAlert(withMessage: "Some thing went wrong")
            self.present(alert, animated: true, completion: nil)
        }
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

