//
//  AirportService.swift
//  Airports
//
//  Created by Lucas Macedo de Lemos on 15/02/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Foundation

protocol AirportServiceProtocol: class {
    func fetchAirports(country: Country, completion: @escaping ((Result<[Airport], ErrorResult>) -> Void))
}

final class AirportService: RequestHandler, AirportServiceProtocol {
    
    static let shared = AirportService()
    
    enum Endpoint: String {
        case airportDatabase
    }
    
    enum Parameter: String {
        case key
        case codeIso2Country
    }
    
    var task: URLSessionTask?
    
    var baseURLString: String {
        guard let urlString = Bundle.main.object(forInfoDictionaryKey: "AVIATION_EDGE_BASE_URL") as? String else {
            return ""
        }
        
        return urlString
    }
    
    var apiKey: String {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "AVIATION_EDGE_API_KEY") as? String else {
            return ""
        }
        
        return apiKey
    }
    
    func fetchAirports(country: Country, completion: @escaping ((Result<[Airport], ErrorResult>) -> Void)) {
        
        self.cancelFetchAirports()
        
        let queryItems = [URLQueryItem(name: Parameter.key.rawValue, value: apiKey),
                          URLQueryItem(name: Parameter.codeIso2Country.rawValue, value: country.rawValue)]
        var urlComponents = URLComponents(string: baseURLString + Endpoint.airportDatabase.rawValue)
        urlComponents?.queryItems = queryItems
        
        task = RequestService().loadData(urlString: urlComponents?.string ?? "", completion: self.networkResult(completion: completion))
    }
    
    func cancelFetchAirports() {
        
        task?.cancel()
        task = nil
    }
}
