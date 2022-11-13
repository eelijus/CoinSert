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
                    TextField("icon : \(category.icon)", text: $icon)
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
                    .onDelete(perform: $category.expenditures.remove)
                    .sheet(item: $selectedExpenditure) { expenditure in
                        ExpenditureModalView(category: category, expenditrueToEdit: expenditure)
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

struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetailView(category: Category())
    }
}
