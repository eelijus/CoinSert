//
//  HeaderDateView.swift
//  InsertCoin
//
//  Created by Suji Lee on 2022/11/16.
//

import SwiftUI

struct HeaderDateView: View {
    
    private let calendar: Calendar = Calendar(identifier: .gregorian)
    
    @Binding var currentDate: Date
    @Binding var currentMonth: Int

    var dateInfo: [String] { return
        extractStringfromDate(currentDate: currentDate)
    }
    
    var body: some View {
        HStack(spacing: 30) {
            Button {
                currentMonth -= 1
                guard let newDate = calendar.date(
                    byAdding: .weekOfMonth,
                    value: -1,
                    to:  currentDate
                ) else {
                    return
                }
                currentDate = newDate
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.yellow)
            }
            VStack {
                Text(dateInfo[0])
                    .font(.caption)
                Button {
                    currentMonth = 0
                    currentDate = Date()
                } label: {
                    Text(dateInfo[1])
                        .font(.title2)
                        .foregroundColor(.black)
                        .offset(x: 3)
                }

            }
            .offset(y: -10)
            Button {
                currentMonth += 1
                guard let newDate = calendar.date(
                    byAdding: .weekOfMonth,
                    value: 1,
                    to: currentDate
                ) else {
                    return
                }
                currentDate = newDate
            } label: {
                Image(systemName: "chevron.right")
                    .foregroundColor(.yellow)
            }
        }
        .padding(.horizontal)
    }
    
    private func extractStringfromDate(currentDate: Date) -> [String] {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "YYYY MMMM"
        formatter.locale = Locale(identifier: "en")
        
        let dateString = formatter.string(from: Calendar.current.date(byAdding: .month, value: currentMonth, to: Date())!)
        
        return dateString.components(separatedBy: " ")
    }
    
    
}

//struct HeaderDateView_Previews: PreviewProvider {
//    static var previews: some View {
//        HeaderDateView()
//    }
//}
