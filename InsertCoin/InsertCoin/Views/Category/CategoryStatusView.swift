//
//  CategoryStatusView.swift
//  InsertCoin
//
//  Created by Suji Lee on 2022/11/11.
//

import SwiftUI
import RealmSwift

struct CategoryStatusView: View {
    
    @ObservedRealmObject var category: Category
    @Binding var currentMonth: Int

    var body: some View {
        VStack {
            if getTotalMonthlyOutlay() >= 0 && getTotalMonthlyOutlay() <= round((category.budget) * 0.4) {
                Text("😎")
            } else if getTotalMonthlyOutlay() > round(category.budget * 0.4) && getTotalMonthlyOutlay() <= round(category.budget * 0.8) {
                Text("🤔")
            } else if getTotalMonthlyOutlay() > round(category.budget * 0.8) && getTotalMonthlyOutlay() < category.budget {
                Text("🚨")
            } else if getTotalMonthlyOutlay() >= category.budget {
                Text("☠️")
            }
        }
        .font(.title2)
    }
    
    private func getTotalMonthlyOutlay() -> Double {
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
}
