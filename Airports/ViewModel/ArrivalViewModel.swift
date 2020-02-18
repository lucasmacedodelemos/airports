//
//  ArrivalViewModel.swift
//  Airports
//
//  Created by Lucas Macedo de Lemos on 18/02/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Foundation

struct ArrivalViewModel {
    
    weak var service: AirportTimetableServiceProtocol?
    weak var dataSourceAndDelegate: GenericDataSourceAndDelegate<AirportTimetable>?
    
    var onErrorHandling: ((ErrorResult?) -> Void)?

    init(service: AirportTimetableServiceProtocol = AirportTimetableService.shared, dataSourceAndDelegate: GenericDataSourceAndDelegate<AirportTimetable>?) {
        self.service = service
        self.dataSourceAndDelegate = dataSourceAndDelegate
    }
    
    func fetchArrivals(iataCode: String) {
        
        guard let service = service else {
            onErrorHandling?(ErrorResult.custom(string: "Missing arrivals service"))
            return
        }
        
        service.fetchAirportTimetable(iataCode: iataCode, type: "arrival") { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let airports):
                    self.dataSourceAndDelegate?.data.value = airports
                case .failure(let error):
                    self.onErrorHandling?(error)
                }
            }
        }
    }
}
