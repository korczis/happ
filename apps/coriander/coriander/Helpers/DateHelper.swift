//
//  DateHelper.swift
//  coriander
//
//  Created by Tomas Korcak on 01.06.2021.
//

import Foundation

class DateHelper {
    static let defaultDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return formatter
    }()
    
    static let defaultPreciseDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss.SSSS"
        return formatter
    }()
}
