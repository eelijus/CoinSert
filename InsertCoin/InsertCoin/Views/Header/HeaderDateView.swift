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
            Button(action: {
                withAnimation{
                    currentMonth -= 1
                }
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.yellow)
            })
            Button(action: {
                withAnimation {
                    currentMonth = 0
                    currentDate = Date()
                }
            }, label: {
                VStack {
                    Text(dateInfo[0])
                        .font(.caption)
                        .foregroundColor(.black)
                    Text(dateInfo[1])
                        .font(.title2)
                        .foregroundColor(.black)
                        .offset(x: 3)
                }
                .offset(y: -10)
            })
            Button(action: {
                withAnimation {
                    currentMonth += 1
                }
            }, label: {
                Image(systemName: "chevron.right")
                    .foregroundColor(.yellow)
            })
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
