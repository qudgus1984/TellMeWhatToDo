//
//  MainView.swift
//  TellMeWhatToDo
//
//  Created by 이병현 on 2023/02/23.
//

import SwiftUI
import CoreData

struct MainView: View {
    @State private var selectedIndex = -1
    @State private var showComposer: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \MemoList.insertDate, ascending: true)],
                  animation: .default) private var memoList: FetchedResults<MemoList>
    var body: some View {
        NavigationView {
            List {
                ForEach(memoList) { memo in
                    NavigationLink {
//                        MemoListDetailView(memo: memoList)
                        MemoListDetailView(memo: memo)
                    } label: {
                        MemoListCell(memo: memo)
                    }
                }
                .onDelete(perform: { indexSet in
                    deleteMemo(offsets: indexSet)
                })
            }
            .listStyle(.plain)
            .navigationTitle("내 메모")
            .toolbar {
                Button {
                    showComposer = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showComposer) {
                MemoListComposeView()
            }
        }
        .navigationViewStyle(.stack)
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
