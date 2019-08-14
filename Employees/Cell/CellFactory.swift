//
//  CellFactory.swift
//  Employees
//
//  Created by pankaj on 8/13/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import UIKit

enum CellType {
    case EmployeeListCell

}

struct CellIdentifier {
    static func type(cellType: CellType) -> String {
        switch cellType {
        case .EmployeeListCell:
            return "cell1"
        }
    }
}

struct CellFactory {
    
    static func cell(forIndexPath indexPath: IndexPath, forTableView tableView: UITableView) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.type(cellType: .EmployeeListCell)) as? EmployeeListTableViewCell
        return cell!
    }
}
