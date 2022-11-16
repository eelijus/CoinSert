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
    
    var body: some View {

        ZStack {
            Rectangle()
                .fill(Color.headerColor)
                .frame(height: 200)
            VStack {
                Text("Period")
                    .offset(x: 15, y: -70)
                Text(String(getTotalOutlay()))
                    .offset(x: 15, y: -50)
                    .font(.largeTitle)
                HStack {
                    Text(String(getTotalBudget() - getTotalOutlay()))
                        .offset(x:20)
                    Spacer()
                    Text(String(getTotalBudget()))
                }
            }
            .offset(x: -10, y: 15)

        }
        .background(Color.headerColor)
    }
    
    func getTotalBudget() -> Int {
        var totalBudget: Double = 0
        
        for i in 0..<categories.count {
            totalBudget += categories[i].budget
        }
        return Int(totalBudget)
    }
    
    func getTotalOutlay() -> Int {
        var totalOutlay: Double = 0
        
        for i in 0..<categories.count {
            totalOutlay += categories[i].totalOutlay
        }
        return Int(totalOutlay)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
