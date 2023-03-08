//
//  OnBoardingLastView.swift
//  TellMeWhatToDo
//
//  Created by 이병현 on 2023/03/08.
//

import SwiftUI

struct OnBoardingLastPageView: View {
    let imageName: String
    let title: String
    let subtitle: String
    
    @Binding var isFirstLaunching: Bool
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .font(.system(size: 100))
                .padding()
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            Text(subtitle)
                .font(.title2)
            
            // 온보딩 완료 버튼.
            // AppStorage의 isFirstLaunching 값을 false로 바꾸기 때문에, 다음번에 앱을 실행할 때는 OnboardingTabView를 띄우지 않음.
            Button {
                isFirstLaunching.toggle()
            } label: {
                Text("시작하기")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(6)
            }
            .padding()
        }
    }
}
