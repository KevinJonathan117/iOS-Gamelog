//
//  HTMLConverter.swift
//  Gamelog
//
//  Created by Kevin Jonathan on 02/10/22.
//

import Foundation

extension String {
    var convertHtmlToString: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
