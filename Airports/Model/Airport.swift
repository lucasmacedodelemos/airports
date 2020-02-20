//
//  Airport.swift
//  Airports
//
//  Created by Lucas Macedo de Lemos on 15/02/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Foundation

struct Airport {
    
    let airportId: Int
    let nameAirport: String
    let codeIataAirport: String
    let codeIso2Country: String
}

extension Airport: Parceable {
    
    static func parseObject(dictionary: [String : Any]) -> Result<Airport, ErrorResult> {
        
        guard let airportId = dictionary["airportId"] as? Int,
            let nameAirport = dictionary["nameAirport"] as? String,
            let codeIataAirport = dictionary["codeIataAirport"] as? String,
            let codeIso2Country = dictionary["codeIso2Country"] as? String else {
                return Result.failure(ErrorResult.parser(string: "Unable to parse airport"))
        }
        
        let airport = Airport(airportId: airportId,
                              nameAirport: nameAirport,
                              codeIataAirport: codeIataAirport,
                              codeIso2Country: codeIso2Country)
        
        return Result.success(airport)
    }
}
