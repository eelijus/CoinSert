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
        HStack(spacing: 20) {
            NavigationLink {
                CategoryDetailView(category: category)
            } label: {
                HStack(spacing: 20) {
                    Text(category.icon)
                        .font(.title)
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
                    VStack {
                        CategoryGaugeView(category: category)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    Button {
                        isPresented = true
                    } label: {
                        CategoryStatusView(category: category)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                    }
                    .sheet(isPresented: $isPresented) {
                        ExpenditureModalView(category: category)
                    }
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
