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
