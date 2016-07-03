//
//  CollectionList.swift
//  SampleProject
//
//  Created by Luisa Qardio on 30/06/2016.
//  Copyright © 2016 Luisa Cruz Molina. All rights reserved.
//

import Foundation
import Freddy

public struct CollectionList {
    public let numberOfObjects: Int?
    public let artObjects: Array<ArtObject>?
}

extension CollectionList: JSONDecodable {
    
    public init(json value: JSON) throws {
        numberOfObjects = try? value.int("count")
        artObjects = try? value.arrayOf("artObjects", type: ArtObject.self)
    }
}