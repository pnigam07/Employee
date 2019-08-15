//
//  EmployeeViewState.swift
//  Employee
//
//  Created by pankaj on 8/12/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import Foundation
import CoreData

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
    
    public var objectId: NSManagedObjectID?
    public var name: String?
    public var email: String?
    public var city: String?
    public var married: String?
    
    init(name: String?, email: String?, city: String?, married: String) {
        self.name = name
        self.email = email
        self.city = city
        self.married = married
    }
    
    init(name: String?, email: String?, city: String?, married: String, objectId: NSManagedObjectID) {
        self.name = name
        self.email = email
        self.city = city
        self.married = married
        self.objectId = objectId
    }
    
    init(employee: Employee) {
 
        self.objectId = employee.objectID
        self.name = employee.name
        self.email = employee.email
        self.city = employee.city
        self.married = employee.married
        
    }
    
    var asDictionary : [String:Any] {
        let mirror = Mirror(reflecting: self)
        let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?,value:Any) -> (String,Any)? in
            guard label != nil else { return nil }
            return (label!,value)
        }).compactMap{ $0 })
        return dict
    }
}




