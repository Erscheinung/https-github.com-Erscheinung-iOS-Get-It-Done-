//
//  CoreDataManager.swift
//  GetItDone
//
//  Created by Kartikeya Chauhan on 07/06/19.
//  Copyright © 2019 Jungian Typology. All rights reserved.
//

import CoreData

struct CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let persistentContainer:NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GetItDone")
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("loading of store failed: \(err)")
            }
        }
        return container
    }()
    
    func createToDo(id: Double, title:String, status:Bool) {
        let context = persistentContainer.viewContext
        let toDo = NSEntityDescription.insertNewObject(forEntityName: "ToDo", into: context)

        toDo.setValue(id, forKey: "id")
        toDo.setValue(title, forKey: "title")
        toDo.setValue(status, forKey: "status")
        
        do {
            try context.save()
        } catch let err {
            print("failed to save context with new toDo:",err)
        }
    }
    
    func fetchToDos() -> [ToDo] {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<ToDo>(entityName: "ToDo")

        do {
            let toDos = try context.fetch(fetchRequest)
            return toDos
        } catch let err {
            print("failed to fetch todos from context",err)
            return []
        }
    }
    
}

