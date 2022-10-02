//
//  DateFormatter.swift
//  Gamelog
//
//  Created by Kevin Jonathan on 02/10/22.
//

import Foundation

class DateUtility {
    static func convertToHumanReadableDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString) ?? Date()
        
        dateFormatter.dateFormat = "d MMM yyyy"
        let newFormat = dateFormatter.string(from: date)
        return newFormat
    }
}
