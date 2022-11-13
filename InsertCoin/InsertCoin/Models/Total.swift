//
//  Total.swift
//  InsertCoin
//
//  Created by Suji Lee on 2022/11/11.
//

import Foundation
import RealmSwift

class Total: Object, Identifiable {
    
    @ObservedResults(Category.self) var categories

    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var budget: Int
    @Persisted var outlay: Int
    
//    override init() {
//        getTotalBudget()
//        getTotalOutlay()
//    }
    
    func getTotalBudget() {
        var totalBudget: Int = 0
        
        for i in 0..<categories.count {
            totalBudget += Int(categories[i].budget)
        }
        self.budget = totalBudget
    }
    
    func getTotalOutlay() {
        var totalOutlay: Int = 0
        
        for i in 0..<categories.count {
            totalOutlay += Int(categories[i].totalOutlay)
        }
        self.outlay = totalOutlay
    }
}
