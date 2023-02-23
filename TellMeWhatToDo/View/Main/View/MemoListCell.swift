//
//  MemoListCell.swift
//  TellMeWhatToDo
//
//  Created by 이병현 on 2023/02/23.
//

import SwiftUI

struct MemoListCell: View {
    @ObservedObject var memo: MemoList
    @Environment(\.managedObjectContext) var contextView
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(memo.content ?? "")
                .font(.body)
                .lineLimit(1)
            Text(memo.insertDate ?? Date(), style: .date)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}



//struct MemoListCell_Previews: PreviewProvider {
//    @Environment(\.managedObjectContext) var contextView
//    static var item = MemoList(context: contextView)
//
//    static var previews: some View {
//        MemoListCell(memo: item)
//    }
//}
