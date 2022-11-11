//
//  HeaderView.swift
//  InsertCoin
//
//  Created by Suji Lee on 2022/11/11.
//

import SwiftUI
import RealmSwift

struct HeaderView: View {

    @ObservedResults(Category.self) var categories
    
    @State private var totalBudget: Double = 0

    var body: some View {
        Text("")
        ForEach(categories, id: \.id) { category in
            totalBudget += category.budget
        }
        
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
