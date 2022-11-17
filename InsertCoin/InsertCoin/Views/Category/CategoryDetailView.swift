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
    
    @State private var isEditing: Bool = false
        
    @Binding var currentDate: Date
    @Binding var currentMonth: Int
    
    @State private var name: String = ""
    @State private var icon: String = ""
    @State private var budget: String = ""
    
    init(category: Category, currentdate: Binding<Date>, currentmonth: Binding<Int>) {
        self.category = category
        
        self._name = State(initialValue: category.name)
        self._icon = State(initialValue: category.icon)
        self._budget = State(initialValue: String(category.budget))
        
        self._currentDate = currentdate
        self._currentMonth = currentmonth
    }
    
    var body: some View {
        let monthlyExpenditures = Array(category.expenditures.filter {
//            isSameMonth(date1: $0.date, date2: currentDate) && getMonthByInt(currentDate) == currentMonth
            getMonthByInt($0.date) == currentMonth
        })
            Button {
                isPresented = true
            } label: {
                Text("💸")
                    .font(.title)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .offset(y: -40)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15))
            .sheet(isPresented: $isPresented) {
                ExpenditureModalView(category: category, date: $currentDate)
            }
            VStack {
                    if !isEditing {
                        VStack(spacing: 15) {
                            HStack(spacing: 20) {
                                Text(category.icon)
                                    .font(.title)
                                Text(category.name)
                            }
                            Text(String(Int(category.budget)))
                                .font(.title2)
                        }
                    } else {
                        VStack {
                            TextField(category.icon, text: $icon)
                            TextField(category.name, text: $name)
                            TextField(String(category.budget), text: $budget)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                Button(action: {
                    if isEditing {
                        update()
                    }
                    isEditing.toggle()
                }, label: {
                    Text(isEditing == false ? "Edit" : "Save")
                })
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
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
    private func update() {
        do {
            let realm = try Realm()
            guard let updatedCategory = realm.object(ofType: Category.self, forPrimaryKey: category.id) else { return }
            try realm.write {
                updatedCategory.name = name
                updatedCategory.icon = icon
                updatedCategory.budget = Double(budget) ?? 0
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
