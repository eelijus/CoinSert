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
    @ObservedResults(Total.self) var total

    @State private var isPresented: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                HeaderView()
                ScrollView {
                    ForEach(categories, id: \.id) { category in
                            CategoryCardView(category: category)
                    }
                }
            }
            .navigationBarItems(trailing: NavigationLink(
                destination: CategoryAddView()
            ) {
               Text("🤑")
                    .font(.title)
            })
        }
    }
    
    
    

}

extension Color {
    static let headerColor = Color("HeaderColor")
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
