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
            Rectangle()
                .fill(.black)
                .frame(width: 3)
            VStack{
                Text(expenditure.name)
                Text(expenditure.date.formatted(date: .omitted, time: .shortened))
            }
            Spacer()
            Text(String(expenditure.amount))
        }
    }
}

struct ExpenditureCardView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenditureCardView(expenditure: Expenditure())
    }
}
