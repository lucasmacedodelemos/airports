//
//  AirportViewModel.swift
//  Airports
//
//  Created by Lucas Macedo de Lemos on 17/02/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Foundation

struct AirportViewModel {
    
    weak var service: AirportServiceProtocol?
    weak var dataSourceAndDelegate: GenericDataSourceAndDelegate<Airport>?

    var onErrorHandling: ((ErrorResult?) -> Void)?
    
    init(service: AirportServiceProtocol = AirportService.shared, dataSourceAndDelegate: GenericDataSourceAndDelegate<Airport>?) {
        self.service = service
        self.dataSourceAndDelegate = dataSourceAndDelegate
    }
    
    func fetchAirports() {
        
        guard let service = service else {
            onErrorHandling?(ErrorResult.custom(string: "Missing airport service"))
            return
        }
        
        service.fetchAirports(country: .PT) { (result) in
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
