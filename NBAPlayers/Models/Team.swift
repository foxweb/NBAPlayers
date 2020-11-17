//
//  Team.swift
//  NBAPlayers
//
//  Created by Aleksandr Anosov on 10.11.2020.
//

import Foundation

struct Team: Decodable {
    let name: String
    let city: String
    let conference: String

    var fullName: String {
        return city + " " + name
    }
}

let lakers = Team(name: "Lakers", city: "Los Angeles", conference: "West")
let heat = Team(name: "Heat", city: "Miami", conference: "East")
