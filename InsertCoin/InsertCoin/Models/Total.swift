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
}
