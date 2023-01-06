//
//  CategoryUtils.swift
//  InsertCoin
//
//  Created by Suji Lee on 2022/11/17.
//

import Foundation
import RealmSwift

func delete(category: Category){
    do {
        let realm = try Realm()
        
        guard let categoryToDelete = realm.object(ofType: Category.self, forPrimaryKey: category.id) else { return }
        try realm.write {
            realm.delete(categoryToDelete)
        }
    }
    catch {
        print(error)
    }
}

func deleteExpenditure(expenditure: Expenditure) {
    do {
        let realm = try Realm()
        
        guard let expenditureToDelete = realm.object(ofType: Expenditure.self, forPrimaryKey: expenditure.id) else { return }
        try realm.write {
            realm.delete(expenditureToDelete)
        }
    }
    catch {
        print(error)
    }
}

func minusExpenditure(category: Category, minusAmount: Double) {
    do {
        let realm = try Realm()
        guard let minusedCategory = realm.object(ofType: Category.self, forPrimaryKey: category.id) else { return }
        try realm.write {
            minusedCategory.totalOutlay -= Double(minusAmount)
        }
    }
    catch {
        print(error)
    }
}

func intToCrrencyDecimal(number: Int) -> String{
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    
    let result = numberFormatter.string(from: NSNumber(value: number))!
    
    return result
}

func doubleToCrrencyDecimal(number: Double) -> String{
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    
    let result = numberFormatter.string(from: NSNumber(value: number))!
    
    return result
}
