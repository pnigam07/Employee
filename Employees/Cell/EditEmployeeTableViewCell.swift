//
//  EditEmployeeTableViewCell.swift
//  Employees
//
//  Created by pankaj on 8/14/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import Foundation

import UIKit

class EditEmployeeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var city: UILabel!
    
    
    func update(viewState: EmployeeViewState){
        name.text = viewState.name
        email.text = viewState.email
        status.text = viewState.married
        city.text = viewState.city
    }
}


