//
//  Date+Ext.swift
//  Recipe Book
//
//  Created by Jesus Andres Bernal Lopez on 1/11/20.
//  Copyright © 2020 Jesus Bernal Lopez. All rights reserved.
//

import UIKit

extension Date {
    
    static let monthDayYearFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"

        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale.current

        return formatter
    }()
    
    func toString() -> String {
        return Date.monthDayYearFormat.string(from: self)
    }
    
    func toDate(fromShortString string: String) -> Date? {
        return Date.monthDayYearFormat.date(from: string)
    }
}
