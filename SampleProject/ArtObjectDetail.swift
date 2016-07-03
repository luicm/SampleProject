//
//  ArtObjectDetail.swift
//  SampleProject
//
//  Created by Luisa Qardio on 30/06/2016.
//  Copyright © 2016 Luisa Cruz Molina. All rights reserved.
//

import Foundation
import Freddy

public struct ArtObjectDetail {
    public let id: String?
    public let title: String?
    public let description: String?
    public let image: ArtObjectImage?
    public let objectTypes: Array<String>?
    public let principalMakers: String?
    public let materials: Array<String>?
    public let date: Int?
    public let physicalMedium: String?
    public let labelDescription: String?
}

extension ArtObjectDetail: JSONDecodable {
    
    public init(json value: JSON) throws {
        id = try? value.string("artObject", "objectNumber")
        title = try? value.string("artObject", "title")
        description = try? value.string("artObject", "description")
        image = try? value.decode("artObject", "webImage", type: ArtObjectImage.self)
        objectTypes = try? value.arrayOf("artObject", "objectTypes", type: Swift.String)
        principalMakers = try? value.string("artObject", "principalOrFirstMaker")
        materials = try? value.arrayOf("artObject", "materials", type: Swift.String)
        date = try? value.int("artObject", "dating", "year")
        physicalMedium = try? value.string("artObject", "physicalMedium")
        labelDescription = try? value.string("artObject", "label", "description")
    }
}