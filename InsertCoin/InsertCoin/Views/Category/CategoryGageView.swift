//
//  CategoryGageView.swift
//  InsertCoin
//
//  Created by Suji Lee on 2022/11/11.
//

import SwiftUI
import RealmSwift

struct CategoryGageView: View {
    
    @ObservedRealmObject var category: Category

    var body: some View {
        Text("Category Gage")
    }
}

struct CategoryGageView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryGageView(category: Category())
    }
}
