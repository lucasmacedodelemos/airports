//
//  RequestHandler.swift
//  Airports
//
//  Created by Lucas Macedo de Lemos on 15/02/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Foundation

class RequestHandler {
    
    func networkResult<T: Parceable>(completion: @escaping ((Result<[T], ErrorResult>) -> Void)) -> ((Result<Data, ErrorResult>) -> Void) {
        
        return { dataResult in
            
            DispatchQueue.global(qos: .background).async(execute: {
                
                switch dataResult {
                case .success(let data):
                    ParserHelper.parse(data: data, completion: completion)
                case .failure(let error):
                    completion(.failure(.network(string: "Network error: \(error.localizedDescription)")))
                }
            })
        }
    }
}
