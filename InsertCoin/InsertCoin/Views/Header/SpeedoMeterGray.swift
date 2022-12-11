//
//  SpeedoMeterGray.swift
//  InsertCoin
//
//  Created by Suji Lee on 2022/12/11.
//

import SwiftUI

struct SpeedoMeterGray: View {
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            ZStack {
                //기본 게이지 위에 덮어질 반원 모양 색상 게이지
                ForEach(1...60, id: \.self) { index in
                    let degree = CGFloat(index) * 3
                    Capsule()
                        .fill(.gray.opacity(0.5))
                        .frame(width: 35, height: 4)
                    //x: x축과 평면을 앞뒤로 기울임. 절대값이 커질수록 더 많이 기울겠지? y: 시계방향(-)/반시계방향(+)으로 기울어짐
                        .offset(x: -(size.width - 50) / 2, y: 4)
                        .rotationEffect(.init(degrees: degree))
                }
            }
            .offset(y: 10)
        }
    }
}

struct SpeedoMeterGray_Previews: PreviewProvider {
    static var previews: some View {
        SpeedoMeterGray()
    }
}
