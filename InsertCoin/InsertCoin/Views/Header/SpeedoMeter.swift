//
//  SpeedoMeter.swift
//  InsertCoin
//
//  Created by Suji Lee on 2022/12/10.
//

import SwiftUI
import RealmSwift

struct SpeedoMeter: View {

    @ObservedResults(Category.self) var categories

    @Binding var currentMonth: Int

    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            Text("\(getOutlayRatio())")

            ZStack {
                //반원 모양 배경 게이지
                //캡슐을 180도로 iterate 했을 뿐
                ForEach(1...60, id: \.self) { index in
                    let degree = CGFloat(index) * 3
                    Capsule()
                        .fill(.gray.opacity(0.25))
                        .frame(width: 40, height: 4)
                        .offset(x: -(size.width - 40) / 2)
                        .rotationEffect(.init(degrees: degree))
                }
                //기본 게이지 위에 덮어질 반원 모양 색상 게이지
                ForEach(1...60, id: \.self) { index in
                    let degree = CGFloat(index) * 3
                    Capsule()
                        .fill(degree < 60 ? .green.opacity(0.5) : (degree >= 60 && degree < 120 ? .yellow.opacity(0.5) : .red.opacity(0.5)))
                        .frame(width: 40, height: 4)
                        .offset(x: -(size.width - 40) / 2)
                        .rotationEffect(.init(degrees: degree))
                }

            }
            .frame(width: size.width, height: size.height, alignment: .bottom)
            //masking for updating progress and animation
            .mask {
                Circle()
                    //원(1)이 기준이기 때문에 반원은 0.5가 최대값임.
                    .trim(from: 0, to: getOutlayRatio() * 0.5)
//                    .trim(from: 0, to: 0.05)
                    .stroke(.white, lineWidth: 40)
                    .frame(width: size.width - 40, height: size.width - 40)
                    .offset(y: -(size.height) / 2)
                    .rotationEffect(.init(degrees: 180))
            }


        }
    }

    //카테고리 하나의 월별 지출액
    private func getTotalMonthlyOutlay(category: Category) -> Double {
        let monthlyExpenditures = Array(category.expenditures.filter {
            getMonthByInt($0.date) == currentMonth
        })

        var totalMonthlyOutlay: Double = 0

        for i in 0..<monthlyExpenditures.count {
            if !monthlyExpenditures.isEmpty {
                totalMonthlyOutlay += monthlyExpenditures[i].amount
            } else {
                totalMonthlyOutlay = 0
            }
        }

        return totalMonthlyOutlay
    }

    //모든 카테고리의 월별 지출액 -> 월 단위 총 사용액
    private func getTotalOutlay() -> Double {

        var totalOutlay: Double = 0

        for i in 0..<categories.count {
            totalOutlay += Double(getTotalMonthlyOutlay(category: categories[i]))
        }
        return totalOutlay
    }

    //총 예산(불변)
    private func getTotalBudget() -> Double {
        var totalBudget: Double = 0

        for i in 0..<categories.count {
            totalBudget += categories[i].budget
        }
        return totalBudget
    }

    //지출 비율 : 월 단위 모든 지출 / 총 예산
    private func getOutlayRatio() -> CGFloat {
        return getTotalOutlay() / getTotalBudget()
    }
}
