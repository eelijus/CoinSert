//
//  CategoryHeaderView.swift
//  InsertCoin
//
//  Created by Suji Lee on 2022/11/17.
//

import SwiftUI
import RealmSwift

struct CategoryHeaderView: View {
    
    @ObservedRealmObject var category: Category
    @State private var isPresented: Bool = false
    @State private var isEditing: Bool = false
    
    @Binding var currentDate: Date
    
    @State private var name: String = ""
    @State private var icon: String = ""
    @State private var budget: String = ""
    
    init(category: Category, currentDate: Binding<Date>) {
        self.category = category
        self._currentDate = currentDate
        
        self._name = State(initialValue: category.name)
        self._icon = State(initialValue: category.icon)
        self._budget = State(initialValue: doubleToCrrencyDecimal(number: category.budget))
    }

    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.categoryColor)
                .frame(height: 200)
            VStack {
                if !isEditing {
                    VStack(spacing: 5) {
                        Text(category.icon)
                                .font(.title)
                        Text(category.name)
                        Text(doubleToCrrencyDecimal(number: category.budget))
                            .font(.title2)
                    }
                } else {
                    VStack(spacing: 5) {
                        TextField(category.icon, text: $icon)
                            .font(.title)
                            .multilineTextAlignment(.center)
                        TextField(category.name, text: $name)
                            .multilineTextAlignment(.center)
                        TextField(doubleToCrrencyDecimal(number: category.budget), text: $budget)
                            .font(.title2)
                            .multilineTextAlignment(.center)
                    }
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
            }
            .offset(y: -10)
        }
        .background(Color.categoryColor)
    }
    
    private func update() {
        do {
            let realm = try Realm()
            guard let updatedCategory = realm.object(ofType: Category.self, forPrimaryKey: category.id) else { return }
            try realm.write {
                updatedCategory.name = name
                updatedCategory.icon = icon
                updatedCategory.budget = Double(budget) ?? category.budget
            }
        }
        catch {
            print(error)
        }
    }
}


