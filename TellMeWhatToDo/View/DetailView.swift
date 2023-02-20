//
//  DetailView.swift
//  TellMeWhatToDo
//
//  Created by 이병현 on 2023/02/20.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var memo: Memo //Publish로 선언한 변수가 변경될 때마다 자동적으로 업데이트시켜줌
    
    @EnvironmentObject var store: MemoStore
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    HStack {
                        Text(memo.content)
                            .padding()
                        
                        Spacer(minLength: 0)
                    }
                    
                    Text(memo.insertDate, style: .date)
                        .padding()
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("메모 보기")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(memo: Memo(content: "Hello"))
            .environmentObject(MemoStore())
    }
}
