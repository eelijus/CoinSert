//
//  CategoryCardView.swift
//  InsertCoin
//
//  Created by Suji Lee on 2022/11/11.
//

import SwiftUI
import RealmSwift

struct CategoryCardView: View {
    
    @State private var isPresented: Bool = false
    @ObservedRealmObject var category: Category
    
    @Binding var currentDate: Date
    @Binding var currentMonth: Int

    var body: some View {
        HStack(spacing: 20) {
            NavigationLink {
                CategoryDetailView(category: category, currentDate: $currentDate, currentMonth: $currentMonth)
            } label: {
                HStack(spacing: 20) {
                    VStack {
                        CategoryStatusView(category: category, currentMonth: $currentMonth)
                            .padding(.leading, 10)
//                        Text(String(getTotalMonthlyOutlay()))
//                            .font(.caption2)
//                            .foregroundColor(.gray)
//                            .frame(alignment: .center)
                    }
                    VStack {
                        CategoryGaugeView(category: category, currentDate: $currentDate, currentMonth: $currentMonth)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    VStack {
                        Button {
                            isPresented = true
                            //월을 변경했을 시 지출 생성 시간이 현재 월로 고정되게 하는 코드
                            var calendar = Calendar(identifier: .gregorian)
                            var component = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
                            component.month = currentMonth
                            currentDate = Calendar.current.date(from: component) ?? Date()
                        } label: {
                            Text(category.icon)
                                .font(.title)
                                .padding(.trailing, 15)
                        }
                        .sheet(isPresented: $isPresented) {
                            ExpenditureModalView(category: category, date: $currentDate)
                        }
//                        Text("\(Int(category.budget))")
//                            .font(.caption2)
//                            .foregroundColor(.gray)
//                            .frame(alignment: .center)
                    }

                }
            }
        }
    }
    
    func getTotalMonthlyOutlay() -> Int {
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
        
        return Int(totalMonthlyOutlay)
    }
}
//
//struct CategoryCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryCardView(category: Category())
//    }
//}
