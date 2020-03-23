//
//  Struct+coders.swift
//  AirportFinder
//
//  Created by André Escajeda Ríos on 22/03/20.
//  Copyright © 2020 André Escajeda Ríos. All rights reserved.
//

import Foundation

struct Airport: Decodable {
    let airportId, code, name: String
    let location: Location
    let cityId, city, countryCode: String
    let themes, pointsOfSale: [String]
    
    struct Location: Decodable {
        let longitude, latitude: Double
    }
    
    enum CodingKeys: String, CodingKey {
        case airportId
        case code, name, location
        case cityId
        case city, countryCode, themes, pointsOfSale
    }
}
