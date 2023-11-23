//
//  PointBackgroundText.swift
//  VersionControl
//
//  Created by Alex Cho on 11/23/23.
//

import Foundation
import SwiftUI

//private이 없으면 적용되는 범위를 가늠하기 어려움
//private을 통해서 해당 구조체는 이 파일 내에서만 사용한다는걸 알 수 있음
private struct PointBackgroundText: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.title)
            .padding(10)
            .foregroundStyle(.white)
            .background(.teal)
            .clipShape(.capsule)
    }
}

extension View{
    func asPointBackgroundText() -> some View{
        modifier(PointBackgroundText())
    }
}
