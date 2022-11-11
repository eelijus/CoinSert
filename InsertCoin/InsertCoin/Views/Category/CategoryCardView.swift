//
//  CategoryCardView.swift
//  InsertCoin
//
//  Created by Suji Lee on 2022/11/11.
//

import SwiftUI
import RealmSwift

struct CategoryCardView: View {
    
    @State private var isPresented: Bool = false
    @ObservedRealmObject var category: Category

    var body: some View {
        HStack {
            CategoryStatusView(category: category)
            Text(category.name)
            VStack {
                CategoryGageView(category: category)
                HStack {
                    Text(String(category.totalOutlay))
                    Text(String(category.budget))
                }

            }
        }
    }
}

struct CategoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCardView(category: Category())
    }
}
