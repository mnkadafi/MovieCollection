//
//  Movie.swift
//  MovieCollection
//
//  Created by Mochamad Nurkhayal Kadafi on 11/05/20.
//  Copyright © 2020 Manusia Apple. All rights reserved.
//

import Foundation
import UIKit

struct Root : Decodable{
    var results : [Movie]
}

struct Movie: Decodable{
    var title : String?
    var overview : String?
    var popularity : Double?
    var poster_path : String?
}
