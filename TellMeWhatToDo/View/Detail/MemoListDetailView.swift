//
//  MemoListDetailView.swift
//  TellMeWhatToDo
//
//  Created by 이병현 on 2023/02/23.
//

import SwiftUI
import Combine


struct MemoListDetailView: View {
        
    @State private var showComposer = false
    @State private var showDeleteAlert = false
    @State private var description = ""
    
    @State private var date = Date()
    @State var memo: MemoList? = nil
    @State private var content: String = ""
    @State private var selectedIndex = -1
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \MemoList.insertDate, ascending: true)],
                  animation: .default) private var memoList: FetchedResults<MemoList>



    
    @Environment(\.dismiss) var dissmiss
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.managedObjectContext) var contextView
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    HStack {
                        Text(content)
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

//struct MemoListDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            MemoListDetailView(memo: Memo(content: "Hello"))
//                .environmentObject(MemoStore())
//        }
//    }
//}
