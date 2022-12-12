//
//  HeaderView.swift
//  InsertCoin
//
//  Created by Suji Lee on 2022/11/11.
//

import SwiftUI
import RealmSwift

struct HeaderView: View {
    
    @State var progress: CGFloat = 0.5
    
    @ObservedResults(Category.self) var categories
    
    @Binding var currentDate: Date
    @Binding var currentMonth: Int
    
    var body: some View {
                
        ZStack {
            Rectangle()
                .fill(Color.headerColor)
                .frame(height: 200)
            VStack {
                HeaderDateView(currentDate: $currentDate,  currentMonth: $currentMonth)
                    .offset(x: 10)
                SpeedoMeter(currentMonth: $currentMonth)
                    .frame(width: 340)
                    .offset(x: 9.3, y: -100)
            }
            .offset(x: -10, y: 15)
            
        }
        .background(Color.headerColor)
    }
    
}
