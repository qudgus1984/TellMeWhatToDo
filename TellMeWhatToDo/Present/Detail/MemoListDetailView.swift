//
//  MemoListDetailView.swift
//  TellMeWhatToDo
//
//  Created by 이병현 on 2023/02/23.
//

import SwiftUI
import Combine
import CoreData

struct MemoListDetailView: View {
    let coreDataStorage = CoreDataStorage(storeType: .inMemory)
    
    @State private var showComposer = false
    @State private var showDeleteAlert = false
    
    @State private var date = Date()
    @State var memo: MemoList? = nil
    @State private var content: String = ""
    @State private var selectedIndex = 0
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \MemoList.insertDate, ascending: true)],
                  animation: .default) private var memoList: FetchedResults<MemoList>
    
    @Environment(\.dismiss) var dissmiss
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    HStack {
                        TextEditor(text: $content)
                            .padding()
                            .onAppear {
                                if let memo {
                                    content = memo.content ?? ""
                                }
                            }
                        Spacer(minLength: 0)
                    }
                    
                    Text(date, style: .date)
                        .padding()
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .onAppear {
                            if let memo {
                                date = memo.insertDate ?? Date()
                            }
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
                        guard let memo = memo else { return } // 선택한 메모 가져오기
                        let index = memoList.firstIndex(of: memo)! // 선택한 메모의 인덱스 가져오기
                        deleteMemo(offsets: IndexSet(integer: index))
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
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    updateMemo(memo: memo, content: content)
                    dissmiss()
                } label: {
                    Text("저장")
                }
            }
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
            let index = offsets.first ?? 0
            selectedIndex = index // update selectedIndex
            offsets.map { memoList[$0] }.forEach(viewContext.delete)
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
}

//struct MemoListDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            MemoListDetailView(memo: Memo(content: "Hello"))
//                .environmentObject(MemoStore())
//        }
//    }
//}
