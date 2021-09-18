//
//  Date.swift
//  Events Arena
//
//  Created by Nada Kamel on 18/09/2021.
//

import Foundation

extension Date {
    
    func toString(withFormat format: String = "dd MMMM, yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}
