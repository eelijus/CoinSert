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
        HStack(alignment: .top) {
            Rectangle()
                .fill(.black)
                .frame(width: 3, height: 60)
            VStack(alignment: .leading) {
                Text(expenditure.date.formatted(date: .omitted, time: .shortened))
                    .foregroundColor(.gray)
                    .font(.caption2)
                Text(expenditure.name)
                    .font(.system(size: 20))
                    .frame(alignment: .center)
                    .offset(y: 6)
            }
            Spacer()
            Text(String(Int(expenditure.amount)))
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color.red)
                .frame(maxHeight: .infinity, alignment: .center)
                .offset(y: -5)
        }
        .background(Color.white) //전체 영역 터치 위에서

    }
}

struct ExpenditureCardView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenditureCardView(expenditure: Expenditure())
    }
}
