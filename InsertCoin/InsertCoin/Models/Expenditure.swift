//
//  Expenditure.swift
//  InsertCoin
//
//  Created by Suji Lee on 2022/11/11.
//

import Foundation
import RealmSwift

class Expenditure: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var amount: Double
    @Persisted var date: Date
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
