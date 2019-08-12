//
//  CoreDataStack.swift
//  CoreDataRemote
//
//  Created by Alfian Losari on 24/09/18.
//  Copyright © 2018 Alfian Losari. All rights reserved.
//

import CoreData

class CoreDataStack {
    
    private init() {}
    static let shared = CoreDataStack()
    
    lazy var persistentContainer: NSPersistentContainer = {
       let container = NSPersistentContainer(name: "Employees")
        
        container.loadPersistentStores(completionHandler: { (_, error) in
            guard let error = error as NSError? else { return }
            fatalError("Unresolved error: \(error), \(error.userInfo)")
        })
        
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.undoManager = nil
        container.viewContext.shouldDeleteInaccessibleFaults = true
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        return container
    }()
    
    func backgroundTaskContext() -> NSManagedObjectContext{
        let taskContext = self.persistentContainer.newBackgroundContext()
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        taskContext.undoManager = nil
        
        return taskContext
    }
    
    func save(context:NSManagedObjectContext){
        do {
            try context.save()
        } catch {
            print("Error: \(error)\nCould not save Core Data context.")
        }
        context.reset() // Reset the context to clean up the cache and low the memory footprint.
    }
    
    
    
}
