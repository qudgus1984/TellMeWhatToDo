//
//  ContentView.swift
//  TellMeWhatToDo
//
//  Created by 이병현 on 2023/02/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \MemoList.insertDate, ascending: false)])
    private var items: FetchedResults<MemoList>
    @AppStorage("_isFirstLaunching") var isFirstLaunching: Bool = true
    
    var body: some View {
        MainView()
            .onAppear {
                if !isFirstLaunching {
                    // 이후 실행 시 ContentView(MainView) 띄우기
                        
                }
            }
            // 앱 최초 구동 시 전체화면으로 OnboardingTabView 띄우기
            .fullScreenCover(isPresented: $isFirstLaunching) {
                OnBoardingTabView(isFirstLaunching: $isFirstLaunching)
                    .onDisappear {
                        // OnBoardingTabView가 닫힐 때 isFirstLaunching 값을 false로 변경
                        isFirstLaunching = false
                    }
            }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
