//
//  EditEmployeeViewController.swift
//  Employees
//
//  Created by pankaj on 8/13/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import UIKit

class EditEmployeeViewController: UIViewController {
    
    private let viewState: EmployeeViewState
    
    init(viewState: EmployeeViewState){
        self.viewState = viewState
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        print("working")
    }
}
