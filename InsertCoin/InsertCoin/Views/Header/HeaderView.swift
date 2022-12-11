//
//  HeaderView.swift
//  InsertCoin
//
//  Created by Suji Lee on 2022/11/11.
//

import SwiftUI
import RealmSwift

struct HeaderView: View {
    
    @State var progress: CGFloat = 0.5

    @ObservedResults(Category.self) var categories
    
    @Binding var currentDate: Date
    @Binding var currentMonth: Int
    
    var body: some View {

        ZStack {
            Rectangle()
                .fill(Color.headerColor)
                .frame(height: 200)
            VStack {
                HeaderDateView(currentDate: $currentDate,  currentMonth: $currentMonth)
                    .offset(x: 10)
                SpeedoMeterGray()
                    .frame(width: 340)
                    .offset(x: 162, y: 178.5)
                SpeedoMeter(currentMonth: $currentMonth)
                    .frame(width: 340)
                    .offset(x: 9.3, y: -100)
            }
            .offset(x: -10, y: 15)

        }
        .background(Color.headerColor)
    }
    
    private func getTotalBudget() -> Int {
        var totalBudget: Double = 0
        
        for i in 0..<categories.count {
            totalBudget += categories[i].budget
        }
        return Int(totalBudget)
    }
    
    private func getTotalMonthlyOutlay(category: Category) -> Int {
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
    
//    func getTotalOutlay() -> Int {
//
//        var totalOutlay: Double = 0
//        
//        for i in 0..<categories.count {
//            totalOutlay += Double(getTotalMonthlyOutlay(category: categories[i]))
//        }
//        return Int(totalOutlay)
//    }
}

//struct HeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        HeaderView()
//    }
//}
