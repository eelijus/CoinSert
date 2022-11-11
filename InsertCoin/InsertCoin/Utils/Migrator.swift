//
//  Migrator.swift
//  InsertCoin
//
//  Created by Suji Lee on 2022/11/11.
//

import Foundation
import RealmSwift

class Migrator {
    
    init() {
        updateSchema()
    }
    
    func updateSchema() {
        
        let config = Realm.Configuration(schemaVersion: 2) { migration, oldSchemaVersion in
            if oldSchemaVersion < 1 {
                // add new fields
                migration.enumerateObjects(ofType: Category.className()) { _, newObject in
                    newObject!["expenditures"] = List<Expenditure>()
                }
            }
            
            if oldSchemaVersion < 2 {
                migration.enumerateObjects(ofType: Expenditure.className()) { _, newObject in
                    newObject!["category"] = ""
                }
            }
            
            
        }
        
        Realm.Configuration.defaultConfiguration = config
        let _ = try! Realm()
        
    }
    
}
