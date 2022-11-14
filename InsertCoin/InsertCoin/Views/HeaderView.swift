//
//  HeaderView.swift
//  InsertCoin
//
//  Created by Suji Lee on 2022/11/11.
//

import SwiftUI
import RealmSwift

struct HeaderView: View {

    @ObservedResults(Category.self) var categories
    
    @State private var totalBudget: Double = 0
    
//    private func getTotalBudget() -> Int {
//        var totalBudget: Int = 0
//        if categories.count == 0 {
//            return 0
//        } else {
//            for i in 0...categories.count {
//                totalBudget += Int(categories[i].budget)
//            }
//            return totalBudget
//        }
//
//    }

    var body: some View {

        ZStack {
            Rectangle()
                .fill(Color.headerColor)
                .frame(height: 200)
            VStack {
                Text("Period")
                    .offset(x: 15, y: -70)
                Text("TotalOutlay")
                    .offset(x: 15, y: -50)
                    .font(.largeTitle)
                HStack {
                    Text("current available")
                        .offset(x:20)
                    Spacer()
                    Text("Total Budget")
                }
            }
            .offset(x: -10, y: 15)

        }
        .background(Color.headerColor)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
