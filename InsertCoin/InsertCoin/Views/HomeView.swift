//
//  HomeView.swift
//  InsertCoin
//
//  Created by Suji Lee on 2022/11/11.
//

import SwiftUI
import RealmSwift

struct HomeView: View {
    
    @ObservedResults(Category.self) var categories
    @State private var isPresented: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                HeaderView()
                    List {
                        ForEach(categories, id: \.id) { category in
                            HStack {
                                NavigationLink {
                                    CategoryDetailView(category: category)
                                } label: {
                                    CategoryCardView(category: category)
                                }
                                Button {
                                    isPresented = true
                                } label: {
                                    Text(category.icon)
                                }
                                .sheet(isPresented: $isPresented) {
                                    ExpenditureModalView(category: category)
                                }
                            }

                        }
                    }
            }
            .navigationBarItems(trailing: NavigationLink(
                destination: CategoryAddView()
            ) {
               Text("💎")
                    .font(.largeTitle)
            })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
