//
//  ComposeView.swift
//  TellMeWhatToDo
//
//  Created by 이병현 on 2023/02/20.
//

import SwiftUI

struct ComposeView: View {
    @EnvironmentObject var store: MemoStore
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var memo: Memo? = nil
    
    @Environment(\.dismiss) var dismiss
    
    @State private var content: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $content)
                    .padding()
                    .onAppear {
                        if let memo {
                            content = memo.content
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
                            store.update(memo: memo, content: content)
                        } else {
                            store.insert(memo: content)
                        }
                                                
                        dismiss()
                    } label: {
                        Text("저장")
                    }

                }

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

struct ComposeView_Previews: PreviewProvider {
    static var previews: some View {
        ComposeView()
            .environmentObject(MemoStore())
    }
}

