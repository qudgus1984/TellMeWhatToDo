//
//  OnBoardingTabView.swift
//  TellMeWhatToDo
//
//  Created by 이병현 on 2023/03/08.
//

//  OnboardingTabView.swift

import SwiftUI

struct OnBoardingTabView: View {
    @Binding var isFirstLaunching: Bool
    
    var body: some View {
        TabView {
            // 페이지 1: 앱 소개
            OnBoardingPageView(
                imageName: "person.3.fill",
                title: "놀라운 개발자 커뮤니티",
                subtitle: "질문을 던지고, 다른 사람의 답변을 확인하세요"
            )
            
            // 페이지 2: 쓰기 페이지 안내
            OnBoardingPageView(
                imageName: "note.text.badge.plus",
                title: "쓰기 탭",
                subtitle: "이 앱은 개인 메모장으로도 쓸 수 있어요"
            )
            
            // 페이지 3: 읽기 페이지 안내 + 온보딩 완료
            OnBoardingLastPageView(
                imageName: "eyes",
                title: "읽기 탭",
                subtitle: "시행착오를 정리해서 공유하고, 다른 개발자들의 인사이트를 얻으세요",
                isFirstLaunching: $isFirstLaunching
            )
        }
        .tabViewStyle(PageTabViewStyle())
    }
}
