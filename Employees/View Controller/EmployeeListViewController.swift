//
//  ViewController.swift
//  Employee
//
//  Created by pankaj on 8/12/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import UIKit
import CoreData

class EmployeeListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let context: NSPersistentContainer
    var dataSource: DataSource
    var viewModel: ListViewModel
    var viewState: EmployeeViewStates
    var adaptor: ListViewAdaptor

    required init?(coder aDecoder: NSCoder) {
        
        context = CoreDataStack.shared.persistentContainer
        viewState = EmployeeViewStates.initialState()
        dataSource = DataSource(persistentContainer: context)
        viewModel = ListViewModel(dataSource: dataSource)
        adaptor = ListViewAdaptor()
        
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setUpDelegates()
    //    killThemAll()
    }
    
    func setupNavigation() {
        self.navigationController?.navigationBar.backgroundColor = .green
        navigationItem.rightBarButtonItem = NavigationBarFactory.setupSystemBarButton(with: .add, target: self, action: #selector(moveToAdd))
        self.title = "Employees"
    }
    
    func setUpDelegates() {
        dataSource.delegate = viewModel
        self.viewModel.delegate = self
        self.viewModel.loadData()
        tableView.delegate = adaptor
        tableView.dataSource = adaptor
        adaptor.delegate = self
    }
    
    func killThemAll() {
        let cc =  CoreDataManger()
        cc.deleteAll()
    }
    
    func insert(){
//        let dict = ["name":"pankaj","email":"aa@fd.com","city":"Bangalore", "married":"true"]
//
//        let cc =  CoreDataManger()
//        cc.insertEmployee(employeeDict: dict)
    }
    
    @objc func moveToAdd() {
        navigationController?.pushViewController(newEmployeeViewController, animated: true)
     //   insert()
    }
   
    fileprivate lazy var newEmployeeViewController: AddNewEmployeeViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: AddNewEmployeeViewController = storyboard.instantiateViewController(withIdentifier: "newEmployee") as! AddNewEmployeeViewController
        return vc
    }()
    
    fileprivate lazy var editViewController: EmployeeDetailViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: EmployeeDetailViewController = storyboard.instantiateViewController(withIdentifier: "editEmployee") as! EmployeeDetailViewController
        return vc
    }()
}

extension EmployeeListViewController: AdaptorDelegate {
    
    func navigatToEditView(viewState: EmployeeViewState) {
        editViewController.viewState = viewState
        navigationController?.pushViewController(editViewController, animated: true)
    }
}

extension EmployeeListViewController: ListViewModelDelegate {
    
    func updateViewState(viewState: EmployeeViewStates) {
        self.viewState = viewState
        self.adaptor.update(viewState: viewState)
        self.tableView.reloadData()
    }
}
