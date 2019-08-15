//
//  EditEmployeeViewController.swift
//  Employees
//
//  Created by pankaj on 8/13/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import UIKit
import CoreData

class EmployeeDetailViewController: UIViewController {
    
    private lazy var cityPicker = UIPickerView()
    private lazy var marritalStatusPicker = UIPickerView()
    private var viewModel: AddNewEmployeeViewModel
    
    var viewState: EmployeeViewState? = nil
    private var toggleRightNavigationBar = false
 
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
       
        setupNavigation()
        setUpView()
    }
    
    func setupNavigation() {
         self.title = "Employe Detail"
         navigationItem.rightBarButtonItem = NavigationBarFactory.setupBarButton(title: "Edit", target: self, action: #selector(editAction(sender:)))
    }
    
    @objc func editAction(sender: UIBarButtonItem) {
        
        if (toggleRightNavigationBar){
            saveRecord()
            sender.title = "Edit"
        }
        else {
                sender.title = "Save"
        }
        toggleRightNavigationBar = !toggleRightNavigationBar
        toggleView(toEdit:toggleRightNavigationBar)
    }
    
    private func saveRecord() {
        let empViewState = EmployeeViewState(name: nameTextField.text?.trimmingCharacters(in: .whitespaces) ?? "",
                                             email: emailTextField.text?.trimmingCharacters(in: .whitespaces) ?? "",
                                             city: cityTextField.text?.trimmingCharacters(in: .whitespaces) ?? "",
                                             married: mariatalStatusTextField.text?.trimmingCharacters(in: .whitespaces) ?? "",
                                             objectId: viewState?.objectId ?? NSManagedObjectID())
        
        CoreDataManger.updateEmployeeRecord(emplyeeViewState: empViewState) { (result) in
            switch result{
            case .success(let message):
                    Utils.showAlert(message: message, viewController: self)
            case .failure(let error):
                Utils.showAlert(message: error.localizedDescription, viewController: self)
            }
            enableEditButton()
        }
        print("record saved")
    }
    
    private func toggleView(toEdit: Bool) {
        nameTextField.isUserInteractionEnabled = toEdit
        emailTextField.isUserInteractionEnabled = toEdit
        mariatalStatusTextField.isUserInteractionEnabled = toEdit
        cityTextField.isUserInteractionEnabled = toEdit
    }
    
    private func setUpView() {
        
        name.text = "Name: "
        email.text = "Email: "
        mariatalStatus.text = "Married: "
        city.text = "City: "
        
        nameTextField.text = viewState?.name
        emailTextField.text = viewState?.email
        mariatalStatusTextField.text = viewState?.married
        cityTextField.text = viewState?.city
        
        toggleView(toEdit: false)
    }
    
    private func enableEditButton() {
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
}

extension EmployeeDetailViewController: NewEmployeeDelegate{
   
    func recordUpdateStatus(result: Result<String, Error>) {
        switch result {
        case .success(_):
                let alert = Utils.getAlert(withMessage: "Record Updated Succesfully")
                self.present(alert, animated: true, completion: nil)
        case .failure(let error):
            print(error)
            let alert = Utils.getAlert(withMessage: "Some thing went wrong")
            self.present(alert, animated: true, completion: nil)
        }
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
