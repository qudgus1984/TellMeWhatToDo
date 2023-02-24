//
//  MemoRepository.swift
//  TellMeWhatToDo
//
//  Created by 이병현 on 2023/02/23.
//

import CoreData

struct MemoModel {
    var content: String
    var id: UUID = UUID()
    var date: Date = Date.now
    
//    init(content: String, date: Date = Date.now) {
//        id = UUID()
//        self.content = content
//        self.date = date
//    }
}

class MemoRepository {
  let coreDataStorage: CoreDataStorage
  
  init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
    self.coreDataStorage = coreDataStorage
  }
  
  func addMemo(content: String) {
    let context = coreDataStorage.taskContext()
    if let savedItem = fetch(content, in: context) {
        savedItem.insertDate = Date()
    } else {
      create(content, in: context)
    }
    
    context.performAndWait {
      do {
        try context.save()
      } catch {
        print(error)
      }
    }
  }
  
  private func fetch(_ content: String, in context: NSManagedObjectContext) -> MemoList? {
    let fetchRequest = MemoList.fetchRequest()
//    fetchRequest.predicate = NSPredicate(format: "content == %@", argumentArray: [content])
    do {
      return try context.fetch(fetchRequest).first
    } catch {
      print("fetch for update Person error: \(error)")
      return nil
    }
  }
  
  fileprivate func create(_ content: String, in context: NSManagedObjectContext) {
    let item = MemoList(context: context)
    item.content = content
    item.insertDate = Date()
  }
  
//  func getItems() -> [MemoModel] {
//    fetchAll()
//          .map(MemoModel.init(content: <#T##String#>))
//  }
  
//  private func fetchAll() -> [MemoList] {
//    let request = MemoList.fetchRequest()
//    request.sortDescriptors = [NSSortDescriptor(keyPath: \MemoList.insertDate, ascending: false)]
//    do {
//      return try coreDataStorage.viewContext.fetch(request)
//    } catch {
//      print("fetch Person error: \(error)")
//      return []
//    }
//  }
}
