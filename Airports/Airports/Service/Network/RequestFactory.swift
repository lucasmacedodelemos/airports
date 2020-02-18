//
//  RequestFactory.swift
//  Airports
//
//  Created by Lucas Macedo de Lemos on 15/02/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Foundation

final class RequestFactory {
    
    enum Method: String {
        
        case GET
        case POST
        case PUT
        case DELETE
        case PATCH
    }
    
    static func request(method: Method, url: URL) -> URLRequest {
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
    
}
