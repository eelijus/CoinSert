//
//  Category.swift
//  InsertCoin
//
//  Created by Suji Lee on 2022/11/11.
//

import Foundation
import RealmSwift


class Category: Object, Identifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId

    @Persisted var name: String
    @Persisted var icon: String
    @Persisted var budget: Double
    @Persisted var totalOutlay: Double
    @Persisted var expenditures: List<Expenditure> = List<Expenditure>()
    
    override class func primaryKey() -> String? {
        "id"
    }
    
    func getCategoryOutlay() {
        var totalOutlay: Int = 0
        
        for i in self.expenditures.count {
            totalOutlay += Int(self.expenditures[i].amount)
        }
        
        self.totalOutlay = totalOutlay
    }
}
