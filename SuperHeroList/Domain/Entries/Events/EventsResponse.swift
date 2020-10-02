//
//  EventsResponse.swift
//  Domain
//
//  Created by Tiago Pereira on 02/10/2020.
//  Copyright © 2020 Tiago Pereira. All rights reserved.
//

import Foundation

public struct EventsResponseData: Codable {
    public let results: [Event]
}

public struct EventsResponse: Codable {
    public let data: EventsResponseData
}
