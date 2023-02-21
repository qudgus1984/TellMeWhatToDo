//
//  MemoCell.swift
//  TellMeWhatToDo
//
//  Created by 이병현 on 2023/02/20.
//

import SwiftUI

struct MemoCell: View {
    @ObservedObject var memo: Memo
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(memo.content)
                .font(.body)
                .lineLimit(1)
            Text(memo.insertDate, style: .date)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}


struct MemoCell_Previews: PreviewProvider {
    static var previews: some View {
        MemoCell(memo: Memo(content: "Test"))
    }
}
