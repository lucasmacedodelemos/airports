//
//  Result.swift
//  Airports
//
//  Created by Lucas Macedo de Lemos on 15/02/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Foundation

enum Result<T, E: Error> {
    
    case success(T)
    case failure(E)
}
