//
//  CoreDataManager.swift
//  Employee
//
//  Created by pankaj on 8/12/19.
//  Copyright © 2019 Nigam. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManger {
    
    func deleteAll(){
        let taskContext = CoreDataStack.shared.backgroundTaskContext()
        taskContext.performAndWait {
            let matchingEpisodeRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
           
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: matchingEpisodeRequest)
            batchDeleteRequest.resultType = .resultTypeObjectIDs
            
            // Execute the request to de batch delete and merge the changes to viewContext, which triggers the UI update
            do {
                let batchDeleteResult = try taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult
                
                if let deletedObjectIDs = batchDeleteResult?.result as? [NSManagedObjectID] {
                    NSManagedObjectContext.mergeChanges(fromRemoteContextSave: [NSDeletedObjectsKey: deletedObjectIDs],
                                                        into: [taskContext])
                }
            } catch {
                print("Error: \(error)\nCould not batch delete existing records.")
                return
            }
            CoreDataStack.shared.save(context: taskContext)
    }
    }
    
    func insertEmployee(employeeDict: Dictionary<String, String>) {
        
        let taskContext = CoreDataStack.shared.persistentContainer.newBackgroundContext()
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        taskContext.undoManager = nil
        
        taskContext.performAndWait {
            
        guard let emp =  NSEntityDescription.insertNewObject(forEntityName: "Employee", into: taskContext) as? Employee else {
                print("Error: Failed to create a new Employee object!")
                return
            }
            
            do {
                try emp.update(with:employeeDict)
            } catch {
                print("Error: \(error)\nThe quake object will be deleted.")
                taskContext.delete(emp)
            }
        CoreDataStack.shared.save(context: taskContext)
    }
    }
}
