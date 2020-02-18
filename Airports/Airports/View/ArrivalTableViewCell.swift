//
//  ArrivalTableViewCell.swift
//  Airports
//
//  Created by Lucas Macedo de Lemos on 18/02/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import UIKit

class ArrivalTableViewCell: UITableViewCell {

    @IBOutlet weak var nameAirlineLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var codesharedLabel: UILabel!
    
    var arrival : AirportTimetable? {
        didSet {
            
            guard let arrival = arrival else {
                return
            }
            
            setupLayout(arrival: arrival)
            setupText(arrival: arrival)
        }
    }
    
    private func setupLayout(arrival: AirportTimetable) {
        
        timeLabel?.isHidden = false
        
        switch arrival.status {
        case .cancelled, .diverted, .incident, .redirected:
            statusLabel?.textColor = .red
            timeLabel?.isHidden = true
        case .unknown:
            timeLabel?.isHidden = true
        case .scheduled:
            statusLabel?.textColor = .orange
        default:
            statusLabel?.textColor = .black
        }
    }
    
    private func setupText(arrival: AirportTimetable) {
        nameAirlineLabel?.text = arrival.airline.name
        numberLabel?.text = arrival.flight.number
        statusLabel?.text = arrival.status.rawValue
        
        timeLabel?.text = arrival.arrival.scheduledTime?.toDate?["hh:mm a"]
        
        if let codeshared = arrival.codeshared?.airline.name {
            codesharedLabel?.text = "Operated by \(codeshared)"
            codesharedLabel?.isHidden = false
        } else {
            codesharedLabel?.isHidden = true
        }
    }

}
