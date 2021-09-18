//
//  String.swift
//  Events Arena
//
//  Created by Nada Kamel on 18/09/2021.
//

import Foundation

extension String {

    func toDate(withFormat format: String = "EEEE, MMM d, yyyy h:mm a") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: self) else { return nil }
        return date
    }
}
