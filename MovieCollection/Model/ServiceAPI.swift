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

class ServiceAPI{
    static let mainURL = "https://api.themoviedb.org/3/movie/upcoming?api_key=4c4df43862b1d6323c2cfe8706f39861&language=en-US&page="
    static let mainImageURL = "https://image.tmdb.org/t/p/original/"
    
    static func getAllData(page: String, completion: @escaping([Movie]?, MovieError) -> Void){
        AF.request(mainURL+page, method: .get, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (responseData) in
            guard let data = responseData.data else {
                completion(nil, .canNotProcessData)
                return}
            do{
                let getmov = try JSONDecoder().decode(Root.self, from: data)
                let movie = getmov.results
                completion(movie, .noDataAvailable)
            }catch{
                completion(nil, .canNotProcessData)
            }
        }
    }
    
    static func getPosterMovie(imageURL : String, completion: @escaping(Data) -> Void){
        AF.download(mainImageURL+imageURL).responseData { response in
            if let data = response.value {
                do{
                    completion(data)
                }catch{
                    completion(data)
                }
            }
        }
    }
}
