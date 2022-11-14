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
    @Persisted var budget: Double
    @Persisted var outlay: Double
    
//    override init() {
//        getTotalBudget()
//        getTotalOutlay()
//    }
    
    func getTotalBudget() {
        var totalBudget: Double = 0
        
        for i in 0..<categories.count {
            totalBudget += categories[i].budget
        }
        self.budget = totalBudget
    }
    
    func getTotalOutlay() {
        var totalOutlay: Double = 0
        
        for i in 0..<categories.count {
            totalOutlay += categories[i].totalOutlay
        }
        self.outlay = totalOutlay
    }
}
