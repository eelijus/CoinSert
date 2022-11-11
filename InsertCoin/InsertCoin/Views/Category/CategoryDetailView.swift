//
//  CategoryDetailView.swift
//  InsertCoin
//
//  Created by Suji Lee on 2022/11/11.
//

import SwiftUI
import RealmSwift

struct CategoryDetailView: View {
    
    @ObservedRealmObject var category: Category

    var body: some View {
        VStack {
            Text(category.name)
            List {
                ForEach(category.expenditures, id: \.id) { expenditure in
                    ExpenditureCardView(expenditure: expenditure)
                }
            }
        }
    }
}

struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetailView(category: Category())
    }
}
