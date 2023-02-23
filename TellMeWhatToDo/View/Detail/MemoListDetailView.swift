//
//  MemoListDetailView.swift
//  TellMeWhatToDo
//
//  Created by 이병현 on 2023/02/23.
//

import SwiftUI
import Combine


struct MemoListDetailView: View {
//    @ObservedObject var memo: Memo //Publish로 선언한 변수가 변경될 때마다 자동적으로 업데이트시켜줌
    
    @EnvironmentObject var store: MemoStore
    
    @State private var selectedIndex = -1
    @State private var showComposer = false
    @State private var showDeleteAlert = false
    @State private var description = ""
    @State private var date = Date()
    
    @Environment(\.dismiss) var dissmiss
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.managedObjectContext) var contextView

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \MemoList.insertDate, ascending: true)],
                  animation: .default) private var memoList: FetchedResults<MemoList>
    @ObservedObject var memo: MemoList
    
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    HStack {
                        
                        Text(description)
                            .padding()
                            .onChange(of: description) { newValue in
                                if newValue != "" {
                                    memo.content = newValue
                                    try? self.contextView.save()
                                }
                            }
                        
                        Spacer(minLength: 0)
                    }
                    
                    Text(date, style: .date)
                        .padding()
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .onChange(of: date) { newValue in
                            memo.insertDate = date
                        }
                }
            }
        }
        .navigationTitle("메모 보기")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button {
                    showDeleteAlert = true
                } label: {
                    Image(systemName: "trash")
                }
                .foregroundColor(.red)
                .alert("삭제 확인", isPresented: $showDeleteAlert) {
                    Button(role: .destructive) {
//                        store.delete(memo: memo)
                        deleteMemo(offsets: IndexSet(integer: selectedIndex))
                        dissmiss()
                    } label: {
                        Text("삭제")
                    }
                } message: {
                    Text("메모를 삭제할까요?")
                }
                
                Button {
                    showComposer = true
                } label: {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
        .sheet(isPresented: $showComposer) {
            MemoListComposeView(memo: memo)
        }
    }
}

extension MemoListDetailView {
    private func addMemoList() {
        withAnimation {
            let newMemo = MemoList(context: viewContext)
            newMemo.content = ""
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
        
    private func deleteMemo(offsets: IndexSet) {
        withAnimation {
            offsets.map { memoList[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct MemoListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(memo: Memo(content: "Hello"))
                .environmentObject(MemoStore())
        }
    }
}
