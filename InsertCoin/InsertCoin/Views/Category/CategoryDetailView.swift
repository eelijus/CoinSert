//
//  CategoryDetailView.swift
//  InsertCoin
//
//  Created by Suji Lee on 2022/11/11.
//

import SwiftUI
import RealmSwift

struct CategoryDetailView: View {
    
    @State private var isPresented: Bool = false
    @ObservedRealmObject var category: Category
    @State private var selectedExpenditure: Expenditure? = nil
    
    @State private var isEditing: Bool = false
    
    @State private var name: String = ""
    @State private var icon: String = ""
    @State private var budget: String = ""

    var body: some View {
        VStack {
            if !isEditing {
                Text(category.icon)
                Text(category.name)
                Text(String(category.budget))
            } else {
                TextField(category.icon, text: $icon)
                TextField(category.name, text: $name)
                TextField(String(category.budget), text: $budget)
            }
            Button(action: {
                if isEditing {
                    update()
                }
                isEditing.toggle()
            }, label: {
                Text(isEditing == false ? "Edit" : "Save")
            })
            List {
                ForEach(category.expenditures, id: \.id) { expenditure in
                    ExpenditureCardView(expenditure: expenditure)
                        .onTapGesture {
                            selectedExpenditure = expenditure
                        }
                }
                .sheet(item: $selectedExpenditure) { expenditure in
                    ExpenditureModalView(category: category, expenditrueToEdit: expenditure)
                }
            }

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

struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetailView(category: Category())
    }
}
