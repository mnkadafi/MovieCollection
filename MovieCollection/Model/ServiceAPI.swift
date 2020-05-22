//
//  ServiceAPI.swift
//  MovieCollection
//
//  Created by Mochamad Nurkhayal Kadafi on 11/05/20.
//  Copyright © 2020 Manusia Apple. All rights reserved.
//

import Foundation
import Alamofire

enum MovieError: Error{
    case noDataAvailable
    case canNotProcessData
}

class Service{
    fileprivate var baseURL = ""
    
    init(baseURL: String){
        self.baseURL = baseURL
    }
    
    func getAllData(completion: @escaping(Result<[Movie], MovieError>) -> Void){
        AF.request(baseURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (responseData) in
            guard let data = responseData.data else {
                completion(.failure(.canNotProcessData))
                return}
            do{
                let getmov = try JSONDecoder().decode(Root.self, from: data)
                let movie = getmov.results
                completion(.success(movie))
            }catch{
                completion(.failure(.canNotProcessData))
            }
        }
    }
}
