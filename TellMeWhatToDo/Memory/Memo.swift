//
//  Memo.swift
//  TellMeWhatToDo
//
//  Created by 이병현 on 2023/02/20.
//

import Foundation
import SwiftUI

class Memo: Identifiable, ObservableObject { // Data를 쉽게 바인딩, 메모를 자동 편집 및 업데이트할 때 필요한 것
    let id: UUID
    @Published var content: String
    let insertDate: Date
    
    init(content: String, insertDate: Date = Date.now) {
        id = UUID()
        self.content = content
        self.insertDate = insertDate
    }
}
