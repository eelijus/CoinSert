//
//  ExpenditureCardView.swift
//  InsertCoin
//
//  Created by Suji Lee on 2022/11/11.
//

import SwiftUI

struct ExpenditureCardView: View {
    
    var expenditure: Expenditure

    var body: some View {
        HStack {
            VStack{
                Text(expenditure.name)
                Text(String(Int(expenditure.amount)))
                    .font(.title2)
            }
            Spacer()
            VStack {
//                Text(expenditure.date.formatted(date: .numeric, time: .omitted))
                Text(expenditure.date.formatted(date: .omitted, time: .shortened))
            }
        }
    }
}

struct ExpenditureCardView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenditureCardView(expenditure: Expenditure())
    }
}
