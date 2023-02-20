//
//  TellMeWhatToDoApp.swift
//  TellMeWhatToDo
//
//  Created by 이병현 on 2023/02/20.
//

import SwiftUI

@main
struct TellMeWhatToDoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
