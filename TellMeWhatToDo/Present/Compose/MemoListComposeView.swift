//
//  MemoListComposeView.swift
//  TellMeWhatToDo
//
//  Created by 이병현 on 2023/02/23.
//

import SwiftUI

struct MemoListComposeView: View {
//    @EnvironmentObject var store: MemoStore
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.managedObjectContext) private var viewContext

    @State var memo: MemoList? = nil
    
    @Environment(\.dismiss) var dismiss
    
    @State private var content: String = ""
    @State private var selectedIndex = -1
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \MemoList.insertDate, ascending: true)],
                  animation: .default) private var memoList: FetchedResults<MemoList>
    
    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $content)
                    .padding()
            }
            .navigationTitle("새 메모")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("취소")
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        addMemoList(content)
                        dismiss()
                    } label: {
                        Text("저장")
                    }
                }
            }
        }
    }
    
    private func addMemoList(_ content: String) {
        withAnimation {
            let newMemo = MemoList(context: viewContext)
            newMemo.content = content
            newMemo.insertDate = Date()
            newMemo.id = UUID()
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
        
    func saveContext() {
      do {
        try managedObjectContext.save()
      } catch {
        print("Error saving managed object context: \(error)")
      }
    }
}

struct MemoListComposeView_Previews: PreviewProvider {
    static var previews: some View {
        MemoListComposeView()
    }
}
