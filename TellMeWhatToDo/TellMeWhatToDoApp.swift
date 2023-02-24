//
//  TellMeWhatToDoApp.swift
//  TellMeWhatToDo
//
//  Created by 이병현 on 2023/02/20.
//

import SwiftUI

//@main
//struct TellMeWhatToDoApp: App {
//    @StateObject var store = MemoStore()
//
//    let persistenceController = PersistenceController.shared
//
//    var body: some Scene {
//        WindowGroup {
//            MainListView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//                .environmentObject(store)
//        }
//    }
//}

@main
struct TellMeWhatToDoApp: App {
  let viewContext = CoreDataStorage.shared.viewContext
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(\.managedObjectContext, viewContext)
    }
  }
}
