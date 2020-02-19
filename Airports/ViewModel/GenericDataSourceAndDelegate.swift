//
//  GenericDataSourceAndDelegate.swift
//  Airports
//
//  Created by Lucas Macedo de Lemos on 17/02/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Foundation

class GenericDataSourceAndDelegate<T>: NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
    var selected: DynamicValue<T?> = DynamicValue(nil)
}
