//
//  AirportTimetableService.swift
//  Airports
//
//  Created by Lucas Macedo de Lemos on 18/02/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Foundation

protocol AirportTimetableServiceProtocol: class {
    func fetchAirportTimetable(iataCode: String, type: String, completion: @escaping ((Result<[AirportTimetable], ErrorResult>) -> Void))
}

final class AirportTimetableService: RequestHandler, AirportTimetableServiceProtocol {
    
    static let shared = AirportTimetableService()
    
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
    
    enum Endpoint: String {
        case timetable
    }
    
    enum Parameter: String {
        case key
        case iataCode
        case type
    }
    
    func fetchAirportTimetable(iataCode: String, type: String, completion: @escaping ((Result<[AirportTimetable], ErrorResult>) -> Void)) {
        
        self.cancelFetchAirportTimetable()

        let queryItems = [URLQueryItem(name: Parameter.key.rawValue, value: apiKey),
                          URLQueryItem(name: Parameter.iataCode.rawValue, value: iataCode),
                          URLQueryItem(name: Parameter.type.rawValue, value: "arrival")]
        var urlComponents = URLComponents(string: baseURLString + Endpoint.timetable.rawValue)
        urlComponents?.queryItems = queryItems
        
        task = RequestService().loadData(urlString: urlComponents?.string ?? "", completion: self.networkResult(completion: completion))
    }
    
    func cancelFetchAirportTimetable() {
        
        task?.cancel()
        task = nil
    }
    
}

