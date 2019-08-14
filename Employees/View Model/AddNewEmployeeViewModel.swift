//
//  AddNewEmployeeViewModel.swift
//  Employees
//
//  Created by pankaj on 8/14/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import Foundation

protocol NewEmployeeDelegate {
    //func recordAddedSuccessfully(result: Result<String,Error>)
    func recordAddedSuccessfully()
}


class AddNewEmployeeViewModel {
    
    var viewState: EmployeeViewState?
    var delegate: NewEmployeeDelegate?
    
    func save(viewState: EmployeeViewState) {
        self.viewState = viewState
        if isValidateData(){
            CoreDataManger.insertEmployee(employeeViewState: viewState)
            delegate?.recordAddedSuccessfully()
        }
    }
    
    private func isValidateData() -> Bool {
        if  viewState?.name?.count ?? 0 < 6 {
            return false
        }
        if !Utils.isValidEmail(emailStr: viewState?.email ?? "") {
            return false
        }
        if viewState?.married == "" {
            return false
        }
        if viewState?.city?.count ?? 0 < 4 {
            return false
        }
        return true
    }
    
}
