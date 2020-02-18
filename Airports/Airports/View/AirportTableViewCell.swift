//
//  AirportTableViewCell.swift
//  Airports
//
//  Created by Lucas Macedo de Lemos on 17/02/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import UIKit

class AirportTableViewCell: UITableViewCell {

    @IBOutlet weak var nameAirport: UILabel!
    @IBOutlet weak var codeIataAirport: UILabel!
    
    var airport : Airport? {
        didSet {
            
            guard let airport = airport else {
                return
            }
            
            nameAirport?.text = airport.nameAirport
            codeIataAirport?.text = airport.codeIataAirport
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
