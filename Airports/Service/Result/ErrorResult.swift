//
//  ErrorResult.swift
//  Airports
//
//  Created by Lucas Macedo de Lemos on 15/02/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Foundation

enum ErrorResult: Error {
    
    case network(string: String)
    case parser(string: String)
    case custom(string: String)
}
