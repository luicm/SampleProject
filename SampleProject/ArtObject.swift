//
//  ArtObject.swift
//  SampleProject
//
//  Created by Luisa Qardio on 30/06/2016.
//  Copyright © 2016 Luisa Cruz Molina. All rights reserved.
//

import Foundation
import Freddy

public struct ArtObject {
    public let objectNumber: String?
    public let title: String?
    public let hasImage: Bool?
    public let principalOrFirstMaker: String?
    public let longTitle: String?
    public let webImage: ArtObjectImage?
    public let headerImage: ArtObjectImage?
    public let productionPlaces: Array<String>?
}

extension ArtObject: JSONDecodable {
    
    public init(json value: JSON) throws {
        objectNumber = try? value.string("objectNumber")
        title = try? value.string("title")
        hasImage = try? value.bool("hasImage")
        principalOrFirstMaker = try? value.string("principalOrFirstMaker")
        longTitle = try? value.string("longTitle")
        webImage = try? value.decode("webImage", type: ArtObjectImage.self)
        headerImage = try? value.decode("headerImage", type: ArtObjectImage.self)
        productionPlaces = try? value.arrayOf("productionPlaces", type: Swift.String)
    }
}
