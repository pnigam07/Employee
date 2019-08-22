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
    var viewModel: DisplayViewModel
    var viewState: EmployeeViewStates
    var adaptor: ListTableViewAdaptor

    required init?(coder aDecoder: NSCoder) {
        context = CoreDataStack.shared.persistentContainer
        viewState = EmployeeViewStates.initialState()
        dataSource = DataSource(persistentContainer: context)
        viewModel = DisplayViewModel(dataSource: dataSource)
        adaptor = ListTableViewAdaptor()
        
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setUpDelegates()
//        killThemAll()
    }
    
    func setupNavigation() {
        self.navigationController?.navigationBar.backgroundColor = .green
        navigationItem.rightBarButtonItem = NavigationBarFactory.setupSystemBarButton(with: .add,
                                                                                      target: self,
                                                                                      action: #selector(moveToAdd))
        self.title = Constants.EmployeListViewTitle
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
    
    @objc func moveToAdd() {
        
        navigationController?.pushViewController(newEmployeeViewController(), animated: true)
    }
   
    fileprivate func newEmployeeViewController() -> NewEmployeeViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: BaseEmployeeViewController = storyboard.instantiateViewController(withIdentifier: "newEmployee") as! BaseEmployeeViewController
        object_setClass(vc, NewEmployeeViewController.self)
        return vc as! NewEmployeeViewController
    }
    
    fileprivate func editViewController() -> EmployeeDetailViewController  {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: BaseEmployeeViewController = storyboard.instantiateViewController(withIdentifier: "newEmployee") as! BaseEmployeeViewController
        object_setClass(vc, EmployeeDetailViewController.self)
        return vc as! EmployeeDetailViewController

    }
}

extension EmployeeListViewController: AdaptorDelegate {
    func navigatToEditView(viewState: EmployeeViewState) {
        
      let edit =  editViewController()
        edit.viewState = viewState
        navigationController?.pushViewController(edit, animated: true)
    }
}

extension EmployeeListViewController: ListViewModelDelegate {
    func updateViewState(viewState: EmployeeViewStates) {
        self.viewState = viewState
        self.adaptor.update(viewState: viewState)
        self.tableView.reloadData()
    }
}
