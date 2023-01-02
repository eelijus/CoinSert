//
//  CategoryDetailView.swift
//  InsertCoin
//
//  Created by Suji Lee on 2022/11/11.
//

import SwiftUI
import RealmSwift

struct CategoryDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var showAlert = false
    @State private var isPresented: Bool = false
    @ObservedRealmObject var category: Category
    @State private var selectedExpenditure: Expenditure? = nil
    
        
    @Binding var currentDate: Date
    @Binding var currentMonth: Int
    
    var body: some View {
            CategoryHeaderView(category: category, currentDate: $currentDate)
            VStack {
                CategoryListView(category: category, currentDate: $currentDate, currentMonth: $currentMonth)
            }
            .safeAreaInset(edge: .bottom, alignment: .center) {
                Button {
                    showAlert = true
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .font(.title)
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Delete Category"), message: Text("are you sure..?"), primaryButton: .destructive(Text("Cancel")), secondaryButton: .cancel(Text("Delete"), action: {
                                delete(category: category)
                            }))
                        }
                }
            }
            .navigationBarItems(trailing:
                VStack {
                Button {
                    isPresented = true
                    //지출을 추가하는 날짜가 현재 날짜라면 해당 월, 일, 시간으로 지출을 생성하고
                    //현재 날짜가 아닌 날짜에서 추가하면 생성 시간을 해당 월, 1일, 12:00am으로 고정되게 하는 코드
                    if currentMonth == getMonthByInt(Date()) {
                        currentDate = Date()
                    } else {
                        currentDate = convertMonthIntToDate(currentMonth)
                    }
                    } label: {
                        Text("💸")
                            .font(.largeTitle)
                    }
                    .sheet(isPresented: $isPresented) {
                        ExpenditureModalView(category: category, date: $currentDate, month: $currentMonth)
                    }
                }
            )
    }
    
    private func extractStringfromDate(currentDate: Date) -> [String] {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "YYYY MMMM"
        formatter.locale = Locale(identifier: "en")
        
        let dateString = formatter.string(from: Calendar.current.date(byAdding: .month, value: currentMonth, to: Date())!)
        
        return dateString.components(separatedBy: " ")
    }
}

//struct CategoryDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryDetailView(category: Category())
//    }
//}
