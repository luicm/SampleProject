//
//  Artist.swift
//  SampleProject
//
//  Created by Luisa Qardio on 30/06/2016.
//  Copyright © 2016 Luisa Cruz Molina. All rights reserved.
//

import Foundation
import Freddy


public struct Artist {
    public let name: String?
    public let placeOfBirth: String?
    public let dateOfBirth: String?
    public let dateOfDeath: String?
    public let occupation: Array<String>?
    public let nationality: String?
    public let productionPlaces: Array<String>?
}

extension Artist: JSONDecodable {
    
    public init(json value: JSON) throws {
        name = try? value.string("name")
        placeOfBirth = try? value.string("placeOfBirth")
        dateOfBirth = try? value.string("dateOfBirth")
        dateOfDeath = try? value.string("dateOfDeath")
        occupation = try? value.arrayOf("occupation", type: Swift.String)
        nationality = try? value.string("nationality")
        productionPlaces = try? value.arrayOf("productionPlaces", type: Swift.String)
    }
}