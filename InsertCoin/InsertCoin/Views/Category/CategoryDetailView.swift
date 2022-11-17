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
        let monthlyExpenditures = Array(category.expenditures.filter {
//            isSameMonth(date1: $0.date, date2: currentDate) && getMonthByInt(currentDate) == currentMonth
            getMonthByInt($0.date) == currentMonth
        })
            CategoryHeaderView(category: category, currentDate: $currentDate)
            VStack {
                List {
                    ForEach(monthlyExpenditures, id: \.id) { expenditure in
                        ExpenditureCardView(expenditure: expenditure)
                            .onTapGesture {
                                selectedExpenditure = expenditure
                                currentDate = expenditure.date
                            }
                            .swipeActions(edge: .trailing) {
                                Button {
                                    minusExpenditure(minusAmount: expenditure.amount)
                                    deleteExpenditure(expenditure: expenditure)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                .tint(.red)
                            }
                    }
                    .sheet(item: $selectedExpenditure) { expenditure in
                        ExpenditureModalView(category: category, date: $currentDate, expenditrueToEdit: expenditure)
                    }
                }
                .background(.white)
                .listStyle(.plain)
                .listRowSeparator(.hidden)
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
        
    }
    
    private func delete(category: Category){
        do {
            let realm = try Realm()
            
            guard let categoryToDelete = realm.object(ofType: Category.self, forPrimaryKey: category.id) else { return }
            try realm.write {
                realm.delete(categoryToDelete)
            }
        }
        catch {
            print(error)
        }
    }
    
    private func deleteExpenditure(expenditure: Expenditure) {
        do {
            let realm = try Realm()
            
            guard let expenditureToDelete = realm.object(ofType: Expenditure.self, forPrimaryKey: expenditure.id) else { return }
            try realm.write {
                realm.delete(expenditureToDelete)
            }
        }
        catch {
            print(error)
        }
    }
    
    private func minusExpenditure(minusAmount: Double) {
        do {
            let realm = try Realm()
            guard let minusedCategory = realm.object(ofType: Category.self, forPrimaryKey: category.id) else { return }
            try realm.write {
                minusedCategory.totalOutlay -= Double(minusAmount)
            }
        }
        catch {
            print(error)
        }
    }
}

//struct CategoryDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryDetailView(category: Category())
//    }
//}
