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
    
    @State var currentDate = Date()
    @State var currentMonth: Int = getMonthByInt(Date())

    @State private var isPresented: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                HeaderView(currentDate: $currentDate, currentMonth: $currentMonth)
                ScrollView {
                    ForEach(categories, id: \.id) { category in
                        CategoryCardView(category: category, currentDate: $currentDate, currentMonth: $currentMonth)
                            .padding(.bottom, 5)
                    }
                }
            }
            .navigationBarItems(trailing: NavigationLink(
                destination: CategoryAddView()
                    .navigationViewStyle(StackNavigationViewStyle())

            ) {
               Text("🤑")
                    .font(.title)
            })
        }
    }
    
    func getCurrentMonth(_ currentMonth: Int) -> Date {
        let calendar = Calendar.current
        // get current month date
        guard let currentMonth = calendar.date(byAdding: .month, value: currentMonth, to: Date()) else {
            return Date()
        }
        return currentMonth
    }
    

}

extension Color {
    static let headerColor = Color("HeaderColor")
    static let categoryColor = Color("CategoryColor")
    static let customGreen = Color("CustomGreen")
    static let customYellow = Color("CustomYellow")
}
