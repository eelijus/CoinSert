//
//  CategoryListView.swift
//  InsertCoin
//
//  Created by Suji Lee on 2022/11/17.
//

import SwiftUI
import RealmSwift

struct CategoryListView: View {
    
    @ObservedRealmObject var category: Category
    @Binding var currentDate: Date
    @Binding var currentMonth: Int
    
    let calendar = Calendar.current

    
    @State private var selectedExpenditure: Expenditure? = nil
    
    var body: some View {
        let monthlyExpenditures = Array(category.expenditures.filter {
            getMonthByInt($0.date) == currentMonth
        })
        let sortedMonthlyExpenditures = monthlyExpenditures.sorted(by: { $0.date < $1.date })
        List {
            ForEach(Array(sortedMonthlyExpenditures.enumerated()), id: \.offset) { i, expenditure in
                    if i == 0 || getDayFromDate(date: monthlyExpenditures[i - 1].date) != getDayFromDate(date: expenditure.date) {
                        HStack {
                            line
                            Text("\(calendar.component(.month, from: expenditure.date))/\(calendar.component(.day, from: expenditure.date))")
                                .foregroundColor(.gray)
                            line
                        }
                    }
                    ExpenditureCardView(expenditure: expenditure)
                        .onTapGesture {
                            selectedExpenditure = expenditure
                            currentDate = expenditure.date
                        }
                        .swipeActions(edge: .trailing) {
                            Button {
                                minusExpenditure(category: category, minusAmount: expenditure.amount)
                                deleteExpenditure(expenditure: expenditure)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            .tint(.red)
                        }
            }
            .listRowSeparator(.hidden)

            .sheet(item: $selectedExpenditure) { expenditure in
                ExpenditureModalView(category: category, date: $currentDate, month: $currentMonth, expenditrueToEdit: expenditure)
            }
            
        }
        .background(.white)
        .listStyle(.plain)
    }
    
    var line: some View {
        VStack{
            Divider().background(Color.gray)
        }
    }
    
    private func getDayFromDate(date: Date) -> Int {
        let day = calendar.component(.day, from: date)
        return day
    }

}

//struct CategoryListView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryListView()
//    }
//}
