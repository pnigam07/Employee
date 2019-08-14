//
//  DataSource.swift
//  Employee
//
//  Created by pankaj on 8/12/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import Foundation
import CoreData

protocol DataSourceDelegate {
    func updateViewState()
}

class DataSource: NSObject {
    
    private let persistentContainer: NSPersistentContainer
    var delegate: DataSourceDelegate?
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
     lazy var fetchedResultsController: NSFetchedResultsController<Employee> = {
        let fetchRequest = NSFetchRequest<Employee>(entityName:"Employee")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending:true)]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: viewContext,
                                                    sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        
        do {
            try controller.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return controller
    }()
}

extension DataSource: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
            delegate?.updateViewState()
    }
    
}
