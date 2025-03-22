//
//  Date+Extended.swift
//  BibleTracker
//
//  Created by Melissa Webster on 3/22/25.
//

import Foundation

extension Date {

    func isEqual(to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
        calendar.isDate(self, equalTo: date, toGranularity: component)
    }

    func isInSameYear (date: Date) -> Bool { isEqual(to: date, toGranularity: .year) }
    func isInSameMonth(date: Date) -> Bool { isEqual(to: date, toGranularity: .month) }
    func isInSameDay  (date: Date) -> Bool { isEqual(to: date, toGranularity: .day) }
    func isInSameWeek (date: Date) -> Bool { isEqual(to: date, toGranularity: .weekOfYear) }

    var isInThisYear:  Bool { isInSameYear(date: Date()) }
    var isInThisMonth: Bool { isInSameMonth(date: Date()) }
    var isInLastMonth: Bool {
        let lastMonth = Calendar.current.date(byAdding: .month, value: -1, to: Date())
        return isInSameMonth(date: lastMonth!)
    }
    var isInNextMonth: Bool {
        let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: Date())
        return isInSameMonth(date: nextMonth!)
    }
    var isInThisWeek:  Bool { isInSameWeek(date: Date()) }

    var isInYesterday: Bool { Calendar.current.isDateInYesterday(self) }
    var isInToday:     Bool { Calendar.current.isDateInToday(self) }
    var isInTomorrow:  Bool { Calendar.current.isDateInTomorrow(self) }

    var isInTheFuture: Bool { self > Date() }
    var isInThePast:   Bool { self < Date() }
    
    func compare(to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> ComparisonResult {
        calendar.compare(self, to: date, toGranularity: component)
    }
}

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
