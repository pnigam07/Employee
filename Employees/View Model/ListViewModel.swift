//
//  ListViewModel.swift
//  Employee
//
//  Created by pankaj on 8/12/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import Foundation
import CoreData

protocol ListViewModelDelegate {
    func updateViewState(viewState: EmployeeViewStates)
}

class DisplayViewModel: NSObject {
    
    var dataSource: DataSource?
    var delegate:ListViewModelDelegate?
    var fetchResult: NSFetchedResultsController<Employee>?
    
    init(dataSource: DataSource){
        self.dataSource = dataSource
        self.fetchResult = dataSource.fetchedResultsController
    }
    
    func loadData(){
        guard let empList = fetchResult?.fetchedObjects else{
            print("No List from DB")
            return
        }
        delegate?.updateViewState(viewState: viewStateFactory(employees: empList))
    }
    
    func viewStateFactory(employees: [Employee]) -> EmployeeViewStates {
      
        let allEmp = employees.map { EmployeeViewState(employee: $0) }
        return EmployeeViewStates(employee: allEmp)
    }
}

extension DisplayViewModel: DataSourceDelegate {
    func updateViewState() {
        guard let empList = fetchResult?.fetchedObjects else{
            print("No List from DB")
            return
        }
        delegate?.updateViewState(viewState: viewStateFactory(employees: empList))
    }
    
    
}

