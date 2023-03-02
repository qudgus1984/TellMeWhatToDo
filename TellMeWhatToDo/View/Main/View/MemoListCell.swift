//
//  MemoListCell.swift
//  TellMeWhatToDo
//
//  Created by 이병현 on 2023/02/23.
//

import SwiftUI

struct MemoListCell: View {
//    @ObservedObject var memo: MemoList
    @Environment(\.managedObjectContext) var viewContext
    @State var content: String = ""
    @State var memo: MemoList? = nil
    @State private var date = Date()

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \MemoList.insertDate, ascending: true)],
                  animation: .default) private var memoList: FetchedResults<MemoList>
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(content)
                .font(.body)
                .lineLimit(1)
                .onAppear {
                    if let memo {
                        content = memo.content ?? ""
                    }
                }
            Text(date, style: .date)
                .font(.caption)
                .foregroundColor(.secondary)
                .onAppear {
                    if let memo {
                        date = memo.insertDate ?? Date()
                    }
                }
        }
    }
}



struct MemoListCell_Previews: PreviewProvider {
    @Environment(\.managedObjectContext) static var viewContext
    static let memo = MemoList(context: viewContext)
    
    static var previews: some View {
        MemoListCell(memo: memo)
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
