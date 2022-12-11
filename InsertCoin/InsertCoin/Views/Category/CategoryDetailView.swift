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
                        //월을 변경했을 시 지출 생성 시간이 현재 월로 고정되게 하는 코드
                        var calendar = Calendar(identifier: .gregorian)
                        var component = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
                        component.month = currentMonth
                        currentDate = Calendar.current.date(from: component) ?? Date()
                    } label: {
                        Text("💸")
                            .font(.largeTitle)
                    }
                    .sheet(isPresented: $isPresented) {
                        ExpenditureModalView(category: category, date: $currentDate)
                    }
                }
            )
    }
}

//struct CategoryDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryDetailView(category: Category())
//    }
//}
