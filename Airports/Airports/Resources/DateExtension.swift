//
//  DateExtension.swift
//  Airports
//
//  Created by Lucas Macedo de Lemos on 18/02/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Foundation

extension Date {
    
    subscript(f: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = f
        return dateFormatter.string(from: self)
    }
}
