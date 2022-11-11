//
//  CategoryStatusView.swift
//  InsertCoin
//
//  Created by Suji Lee on 2022/11/11.
//

import SwiftUI
import RealmSwift

struct CategoryStatusView: View {
    
    @ObservedRealmObject var category: Category

    var body: some View {
        if category.totalOutlay >= 0 && category.totalOutlay <= round((category.budget) * 0.4) {
            Text("😎")
        } else if category.totalOutlay > round(category.budget * 0.4) && category.totalOutlay <= round(category.budget * 0.8) {
            Text("🤔")
        } else if category.totalOutlay > round(category.budget * 0.8) && category.totalOutlay < category.budget {
            Text("🚨")
        } else if category.totalOutlay >= category.budget {
            Text("☠️")
        }
    }
}

struct CategoryStatusView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryStatusView(category: Category())
    }
}
