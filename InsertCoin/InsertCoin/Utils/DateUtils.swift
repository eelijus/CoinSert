//
//  DateUtils.swift
//  InsertCoin
//
//  Created by Suji Lee on 2022/11/16.
//

import Foundation


func isSameMonth(date1: Date, date2: Date) -> Bool {
    let date1 = Calendar.current.dateComponents([.year, .month], from: date1)
    let date2 = Calendar.current.dateComponents([.year, .month], from: date2)

    if date1 == date2 {
        return true
    } else {
        return false
    }
}

//나중에 isSameDate로 함수명 변경
func isSameDay(date1: Date, date2: Date) -> Bool {
    let calendar = Calendar.current
    return calendar.isDate(date1, inSameDayAs: date2)
}

//인자 : 날짜 / 반환 : 표식
func getMonthByInt(_ date: Date) -> Int {
    let today = Calendar.current.dateComponents([.year, .month], from: Date())
    let selected = Calendar.current.dateComponents([.year, .month], from: date)
    let monthInt = (selected.year! * 12 + selected.month!) - (today.year! * 12 + today.month!)
    return monthInt
}



// 인자: 표식 / 반환 : 날짜
func convertMonthIntToDate(_ monthInt: Int) -> Date {

    let calendar = Calendar(identifier: .gregorian)
    
    let currentDateComponent = Calendar.current.dateComponents([.year, .month], from: Date())
        
    var resultYear: Int = currentDateComponent.year! + monthInt / 12
    var resultMonth: Int = currentDateComponent.month! + monthInt % 12
    
    var resultDateComponent = Calendar.current.dateComponents([.year, .month], from: Date())
    resultDateComponent.year = resultYear
    resultDateComponent.month = resultMonth
    
    var resultDate: Date
    
    resultDate = Calendar.current.date(from: resultDateComponent)!
    
    return resultDate
    
}
