//
//  CategoryAddView.swift
//  InsertCoin
//
//  Created by Suji Lee on 2022/11/11.
//

import SwiftUI
import RealmSwift

struct CategoryAddView: View {

    @ObservedResults(Category.self) var categories
    
    @State private var name: String = ""
    @State private var icon: String = ""
    @State private var budget: String = ""

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Icon will represent this category", text: $icon)
                    TextField("Category name", text: $name)
                } header: {
                    Text("😎")
                }
                Section {
                    TextField("Category budget", text: $budget)
                } header: {
                    Text("💵")
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        createCategory()
                        dismiss()
                    }
                    .disabled(name == "" || icon == "" || budget == "")
                }
            }
        }
    }
    
    private func createCategory() {
        let newCategory = Category()
        newCategory.name = name
        newCategory.icon = icon
        newCategory.budget = Double(budget) ?? 0
        $categories.append(newCategory)
    }
}

struct CategoryAddView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryAddView()
    }
}
