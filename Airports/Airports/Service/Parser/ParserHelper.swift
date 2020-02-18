//
//  ParserHelper.swift
//  Airports
//
//  Created by Lucas Macedo de Lemos on 15/02/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Foundation

protocol Parceable {
    
    static func parseObject(dictionary: [String: Any]) -> Result<Self, ErrorResult>
}

final class ParserHelper {
    
    static func parse<T: Parceable>(data: Data, completion : (Result<[T], ErrorResult>) -> Void) {
        
        do {
            if let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [AnyObject] {
                
                var finalResult : [T] = []
                
                for object in result {
                    if let dictionary = object as? [String : AnyObject] {
                        
                        switch T.parseObject(dictionary: dictionary) {
                        case .failure(_):
                            continue
                        case .success(let newModel):
                            finalResult.append(newModel)
                        }
                    }
                }
                
                completion(.success(finalResult))
            } else {
                completion(.failure(.parser(string: "Json data is not an array")))
            }
        } catch {
            completion(.failure(.parser(string: "Error while parsing json data")))
        }
    }
    
    static func parse<T: Parceable>(data: Data, completion : (Result<T, ErrorResult>) -> Void) {
        
        do {
            if let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject] {
                
                switch T.parseObject(dictionary: dictionary) {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let newModel):
                    completion(.success(newModel))
                }
            } else {
                completion(.failure(.parser(string: "Json data is not an array")))
            }
        } catch {
            completion(.failure(.parser(string: "Error while parsing json data")))
        }
    }
}
