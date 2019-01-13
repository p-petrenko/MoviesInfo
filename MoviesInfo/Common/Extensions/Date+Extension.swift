//
//  Date+Extension.swift
//  MoviesInfo
//
//  Created by Polina Petrenko on 13/01/2019.
//  Copyright © 2019 Polina Petrenko. All rights reserved.
//

import Foundation

extension Date {
    init(calendar: Calendar? = Calendar.current,
         timeZone: TimeZone? = TimeZone.current,
         year: Int? = Date().year,
         month: Int? = Date().month,
         day: Int? = Date().day)
    {
        var components = DateComponents()
        components.calendar = calendar
        components.timeZone = timeZone
        components.year = year
        components.month = month
        components.day = day
        
        self = calendar?.date(from: components) ?? Date()
    }
    
    var calendar: Calendar {
        return Calendar.current
    }
    
    var timeZone: TimeZone {
        return self.calendar.timeZone
    }
    
    var year: Int {
        get {
            return calendar.component(.year, from: self)
        }
        set {
            self = Date(calendar: calendar, timeZone: timeZone, year: year, month: month, day: newValue)
        }
    }
    
    var month: Int {
        get {
            return calendar.component(.month, from: self)
        }
        set {
            self = Date(calendar: calendar, timeZone: timeZone, year: year, month: month, day: newValue)
        }
    }
    
    var day: Int {
        get {
            return calendar.component(.day, from: self)
        }
        set {
            self = Date(calendar: calendar, timeZone: timeZone, year: year, month: month, day: newValue)
        }
    }
    
}
