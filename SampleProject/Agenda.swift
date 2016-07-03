//
//  Agenda.swift
//  SampleProject
//
//  Created by Luisa Cruz Molina on 02/07/2016.
//  Copyright © 2016 Luisa Cruz Molina. All rights reserved.
//

import Foundation
import Freddy



public struct Agenda {
    public let events: Array<Event>?
}

extension Agenda: JSONDecodable {
    
    public init(json value: JSON) throws {
        events = try? value.arrayOf("options", type: Event.self)
    }
}

public struct Event {
    public let name: String?
    public let description: String?
    public let price: Int?
    public let groupType: String?
    public let descriptionURL: String?
    public let ticketsURL: String?
    public let expositionType: String?
    public let maximum: Int?
    public let current: Int?
    public let remaining: Int?
    public let hours: String?
}

extension Event: JSONDecodable {
    
    public init(json value: JSON) throws {
        name = try? value.string("exposition", "name")
        description = try? value.string("exposition", "description")
        price = try? value.int("exposition", "price", "amount")
        groupType = try? value.string("groupType", "friendlyName")
        descriptionURL = try? value.string("pageRef", "url")
        ticketsURL = try? value.string("links", "web")
        expositionType = try? value.string("expositionType", "friendlyName")
        maximum = try? value.int("period", "maximum")
        current = try? value.int("period", "current")
        remaining = try? value.int("period", "remaining")
        hours = try? value.string("period", "text")
    }
}