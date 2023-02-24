//
//  MemoListComposeView.swift
//  TellMeWhatToDo
//
//  Created by 이병현 on 2023/02/23.
//

import SwiftUI

struct MemoListComposeView: View {
    @EnvironmentObject var store: MemoStore
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.managedObjectContext) private var viewContext

    var memo: MemoList? = nil
    
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
                    .onAppear {
                        if let memo {
                            content = memo.content ?? ""
                        }
                    }
                //textField같은 것
            }
            .navigationTitle(memo != nil ? "메모 편집" : "새 메모")
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
                        if let memo = memo {
//                            store.update(memo: memo, content: content)
//                            store.addMemo(content: content)
                            updateMemo(memo: memo, content: content)
                        } else {
                            addMemoList(content)
                        }
                                                
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
    
    private func updateMemo(memo: MemoList?, content: String) {
        withAnimation {
            guard let memo = memo else {
                return
            }
            memo.content = content
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
            .environmentObject(MemoStore())
    }
}
