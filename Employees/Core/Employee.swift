//
//  Employee.swift
//  Employee
//
//  Created by pankaj on 8/12/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import CoreData

class Employee: NSManagedObject {
    
    @NSManaged var name: String
    @NSManaged var email: String
    @NSManaged var city: String
    @NSManaged var married: String
  
    func update(with jsonDictionary: [String: Any]) throws {
        guard let name = jsonDictionary["name"] as? String,
            let email = jsonDictionary["email"] as? String,
            let city = jsonDictionary["city"] as? String,
            let married = jsonDictionary["married"] as? String
        
            else {
                throw NSError(domain: "", code: 100, userInfo: nil)
        }
        
        self.name = name
        self.email = email
        self.city = city
        self.married = married
    }
    
}
