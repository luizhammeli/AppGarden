//
//  Date+Formatter.swift
//  AppGardenTests
//
//  Created by Luiz Diniz Hammerli on 28/08/23.
//

import Foundation

extension Date {
    static func makeFakeDate(strDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.date(from: strDate) ?? Date()
    }
}
