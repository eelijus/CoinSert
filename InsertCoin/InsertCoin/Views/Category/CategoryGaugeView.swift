//
//  CategoryGageView.swift
//  InsertCoin
//
//  Created by Suji Lee on 2022/11/11.
//

import SwiftUI
import RealmSwift

struct CategoryGaugeView: View {
    
    @ObservedRealmObject var category: Category
    let gradient = Gradient(colors: [.green, .yellow, .orange, .red])
    
    @Binding var currentDate: Date
    @Binding var currentMonth: Int
    


    var body: some View {
        VStack {
            Gauge(value: Double(getTotalMonthlyOutlay()), in: 0...category.budget) {
                Text("")
            } currentValueLabel: {
                Text("")
            } minimumValueLabel: {
                Text("")
                    .foregroundColor(.black)
            } maximumValueLabel: {
                Text("")
                    .foregroundColor(.black)
            }
        }
        .gaugeStyle(.linearCapacity)
        .tint(gradient)
    }
    
    private func getTotalMonthlyOutlay() -> Int {
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

//struct CategoryGaugeView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryGaugeView(category: Category())
//    }
//}
