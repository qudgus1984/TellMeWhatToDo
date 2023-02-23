//
//  ContentView.swift
//  TellMeWhatToDo
//
//  Created by 이병현 on 2023/02/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
  let repo = MemoRepository()
  
  var body: some View {
    Text("Hello, world!")
      .padding()
      .onAppear {
        repo.add(name: "jake")
        repo.add(name: "kim")
        print(repo.getItems())
        // [ExCoredata.MyItemModel(name: "kim"), ExCoredata.MyItemModel(name: "jake")]
      }
    }
}
