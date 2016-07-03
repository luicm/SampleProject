//
//  ArtObjectImage.swift
//  SampleProject
//
//  Created by Luisa Qardio on 30/06/2016.
//  Copyright © 2016 Luisa Cruz Molina. All rights reserved.
//

import Foundation
import Freddy

public struct ArtObjectImage {
    public let guid: String?
    public let offsetPercentageX: Int?
    public let offsetPercentageY: Int?
    public let width: Int?
    public let height: Int?
    public let url: String?
}

extension ArtObjectImage: JSONDecodable {
    
    public init(json value: JSON) throws {
        guid = try? value.string("guid")
        offsetPercentageX = try? value.int("offsetPercentageX")
        offsetPercentageY = try? value.int("offsetPercentageY")
        width = try? value.int("width")
        height = try? value.int("height")
        url = try? value.string("url")
    }
}
