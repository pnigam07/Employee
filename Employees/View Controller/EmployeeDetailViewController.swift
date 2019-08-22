//
//  DetailVC.swift
//  Employees
//
//  Created by pankaj on 8/15/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EmployeeDetailViewController: BaseEmployeeViewController {
    
    private var toggleRightNavigationBar = false
    
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
    
    @objc func editAction(sender: UIBarButtonItem){
        
        if (toggleRightNavigationBar){
            let empViewState = EmployeeViewState(name: nameTextField.text?.trimmingCharacters(in: .whitespaces) ?? "",
                                                 email: emailTextField.text?.trimmingCharacters(in: .whitespaces) ?? "",
                                                 city: cityTextField.text?.trimmingCharacters(in: .whitespaces) ?? "",
                                                 married: mariatalStatusTextField.text?.trimmingCharacters(in: .whitespaces) ?? "",
                                                 objectId: viewState?.objectId ?? NSManagedObjectID())
            
            viewModel.update(viewState: empViewState)
            sender.title = "Edit"
        }
        else {
            sender.title = "Save"
        }
        toggleRightNavigationBar = !toggleRightNavigationBar
        toggleView(toEdit:toggleRightNavigationBar)
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
        case .success(let message):
            Utils.showAlert(message: message, title: Constants.SuccessTitle, viewController: self)
        case .failure(let error):
            print(error)
            Utils.showAlert(message: error.localizedDescription, title: Constants.ErrorTitle, viewController: self)
        }
    }
}
