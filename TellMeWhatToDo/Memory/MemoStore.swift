//
//  MemoStore.swift
//  TellMeWhatToDo
//
//  Created by 이병현 on 2023/02/20.
//

import Foundation
import CoreData

class MemoStore: ObservableObject {
    @Published var list: [Memo]
    
    @FetchRequest(entity: MemoList.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \MemoList.insertDate, ascending: true)])
    
    init() {
        list = [
            Memo(content: "Hello", insertDate: Date.now),
            Memo(content: "Awesome", insertDate: Date.now.addingTimeInterval(3600 * -24)),
            Memo(content: "SwiftUI", insertDate: Date.now.addingTimeInterval(3600 * -48))
        ]
    }
    
    func insert(memo: String) {
        list.insert(Memo(content: memo), at: 0)
    }
    
    func update(memo: Memo?, content: String) {
        guard let memo = memo else {
            return
        }
        
        memo.content = content
    }
    
    func delete(memo: Memo) {
        list.removeAll { $0.id == memo.id }
    }
    
    func delete(set: IndexSet) {
        for index in set {
            list.remove(at: index)
        }
    }
    
    func addMemo(content: String) {
    }
}
