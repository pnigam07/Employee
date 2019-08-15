//
//  NewEmployeeVC.swift
//  Employees
//
//  Created by pankaj on 8/15/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import Foundation

class NewEmployeeViewController: BaseEmployeeViewController {
    
    override func viewDidLoad() {
        setupNavigation()
        setUpView()
        self.viewModel.delegate = self
        nameTextField.text = nil
        emailTextField.text = nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        nameTextField.text = nil
        emailTextField.text = nil
        
    }
    
    func setupNavigation(){
        self.title = Constants.NewEmployeePageTitle
        navigationItem.rightBarButtonItem = NavigationBarFactory.setupBarButton(title: "Save",
                                                                                target: self,
                                                                                action: #selector(save))
    }
    
    @objc private func save() {
        let empViewState = EmployeeViewState(name: nameTextField.text?.trimmingCharacters(in: .whitespaces) ?? "",
                                             email: emailTextField.text?.trimmingCharacters(in: .whitespaces) ?? "",
                                             city: cityTextField.text?.trimmingCharacters(in: .whitespaces) ?? "",
                                             married: mariatalStatusTextField.text?.trimmingCharacters(in: .whitespaces) ?? "")
        self.viewModel.save(viewState: empViewState)
    }
    
    func setUpView(){
        name.text = "Name: "
        email.text = "Email: "
        mariatalStatus.text = "Married: "
        city.text = "City: "
        nameTextField.text = nil
        emailTextField.text = nil
        mariatalStatusTextField.text = Constants.marritialStatusArray.first
        cityTextField.text = Constants.cityArray.first
    }
}

extension NewEmployeeViewController: NewEmployeeDelegate {
    func recordUpdateStatus(result: Result<String, Error>) {
        switch result {
        case .success(_):
            Utils.showAlert(message: Constants.newRecodSuccessMessgae, title: Constants.SuccessTitle, viewController: self)
        case .failure(let error):
            Utils.showAlert(message: error.localizedDescription, title: Constants.ErrorTitle, viewController: self)
        }
    }
}
