//
//  ContentView.swift
//  TellMeWhatToDo
//
//  Created by 이병현 on 2023/02/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \MemoList.insertDate, ascending: false)])
  private var items: FetchedResults<MemoList>
  let repo = MemoRepository()
  
  var body: some View {
    VStack {
      ForEach(items) { item in
        Text(item.content!)
      }
      Text("Hello, world!")
        .padding()
        .onAppear {
          print(items.count)
          // 샘플 데이터 준비
           repo.addMemo(content: "hi")
           repo.addMemo(content: "everyone")
        }
      Button("Add 'jake123'") {
        addItem("jake123")
      }
    }
  }
  
  private func addItem(_ content: String) {
    withAnimation {
      let newItem = MemoList(context: viewContext)
      newItem.insertDate = Date()
      newItem.content = content
      do {
        try viewContext.save()
      } catch {
        print(error)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
