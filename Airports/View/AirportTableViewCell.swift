//
//  AirportTableViewCell.swift
//  Airports
//
//  Created by Lucas Macedo de Lemos on 17/02/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import UIKit

class AirportTableViewCell: UITableViewCell {

    @IBOutlet weak var nameAirportLabel: UILabel!
    @IBOutlet weak var codeIataAirportLabel: UILabel!
    
    var airport : Airport? {
        didSet {
            
            guard let airport = airport else {
                return
            }
            
            nameAirportLabel?.text = airport.nameAirport
            codeIataAirportLabel?.text = airport.codeIataAirport
        }
    }
}
