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


    var body: some View {
        VStack {
            Gauge(value: category.totalOutlay, in: 0...category.budget) {
                Text("")
            } currentValueLabel: {
                Text("")
            } minimumValueLabel: {
                Text("\(Int(category.totalOutlay))")
                    .foregroundColor(.black)
            } maximumValueLabel: {
                Text("\(Int(category.budget))")
                    .foregroundColor(.black)
            }
        }
        .gaugeStyle(.linearCapacity)
        .tint(gradient)

    }
}

struct CategoryGaugeView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryGaugeView(category: Category())
    }
}
