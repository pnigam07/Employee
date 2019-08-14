//
//  EmployeeViewState.swift
//  Employee
//
//  Created by pankaj on 8/12/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import Foundation

import Foundation

struct EmployeeViewStates: Equatable {
    static func == (lhs: EmployeeViewStates, rhs: EmployeeViewStates) -> Bool {
        return true
    }
    public let employee: [EmployeeViewState]
}

extension EmployeeViewStates {
    
    static func initialState() -> EmployeeViewStates {
        return EmployeeViewStates(employee: [])
    }
}

struct EmployeeViewState {
    
    let employee: Employee
    
    public var name: String?
    public var email: String?
    public var city: String?
    public var married: String?
    
    init(employee: Employee) {
        self.employee = employee
        
        self.name = employee.name
        self.email = employee.email
        self.city = employee.city
        self.married = employee.married
        
    }
}




