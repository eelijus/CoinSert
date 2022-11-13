//
//  ExpenditureAddView.swift
//  InsertCoin
//
//  Created by Suji Lee on 2022/11/11.
//

import SwiftUI
import RealmSwift

struct ExpenditureModalView: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedRealmObject var category: Category
    
    var expenditrueToEdit: Expenditure?
    
    @State var name: String = ""
    @State var date: Date = Date()
    @State var amount: String = ""
    
    init(category: Category, expenditrueToEdit: Expenditure? = nil) {
        self.category = category
        self.expenditrueToEdit = expenditrueToEdit
        
        if let expenditrueToEdit = expenditrueToEdit {
            _name = State(initialValue: expenditrueToEdit.name)
            _date = State(initialValue: expenditrueToEdit.date)
            _amount = State(initialValue: String(expenditrueToEdit.amount))
        }
    }

    var body: some View {
        NavigationView {
            VStack() {
                VStack {
                    Text(category.icon)
                        .font(.largeTitle)
                    Text(category.name)
                        .font(.title2)
                }
                .foregroundColor(.black)
                .padding()
                List {
                    Section {
                        TextField("Name", text: $name)
                        TextField("Amount", text: $amount)
                        HStack {
                            Text("Date")
                                .foregroundColor(.gray)
                            Spacer()
                            DatePicker("", selection: $date)
                                .datePickerStyle(.compact)
                                .labelsHidden()
                        }
                    } header: {
                        Text("💸")
                            .font(.largeTitle)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if let _ = expenditrueToEdit {
                            updateExpenditure()
                        } else {
                            createExpenditure()
                        }
                        dismiss()
                    }
                    .disabled(amount == "")
                }
            }
        }
    }
    
    private func updateExpenditure() {
        if let expenditrueToEdit = expenditrueToEdit {
            do {
                let realm = try Realm()
                guard let expenditureToUpdate = realm.object(ofType: Expenditure.self, forPrimaryKey: expenditrueToEdit.id) else { return }
                try realm.write {
                    expenditureToUpdate.name = name
                    expenditureToUpdate.amount = Double(amount) ?? 0
                    expenditureToUpdate.date = date
                }
            }
            catch {
                print(error)
            }
        }
    }
    
    private func createExpenditure() {
        let newExpenditure = Expenditure()
        newExpenditure.name = name
        newExpenditure.amount = Double(amount) ?? 0
        newExpenditure.date = date
        $category.expenditures.append(newExpenditure)
    }
}

struct ExpenditureModalView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenditureModalView(category: Category())
    }
}
