//
//  ListViewAdaptor.swift
//  Employee
//
//  Created by pankaj on 8/12/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import UIKit
import Foundation

protocol AdaptorDelegate {
     func navigatToEditView(viewState: EmployeeViewState)
}

class ListViewAdaptor: NSObject {
    
    var delegate: AdaptorDelegate?
    fileprivate var viewState = EmployeeViewStates.initialState()
    
    func update(viewState: EmployeeViewStates){
        self.viewState = viewState
    }
}

extension ListViewAdaptor: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       delegate?.navigatToEditView(viewState: viewState.employee[indexPath.row])
    }
}

extension ListViewAdaptor: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return viewState.employee.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let employee = self.viewState.employee[indexPath.row]
        
        let cell = CellFactory.cell(forIndexPath: indexPath, forTableView: tableView) as? EmployeeListTableViewCell
        cell?.update(viewState: employee)
        return cell ?? UITableViewCell.init(style: .default, reuseIdentifier: "cell1")
    }
}
