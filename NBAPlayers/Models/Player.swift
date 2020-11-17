//
//  Player.swift
//  NBAPlayers
//
//  Created by Aleksandr Anosov on 09.11.2020.
//

import Foundation

struct Player: Decodable {
    let firstName: String
    let lastName: String

    let heightFeet: Int?
    let heightInches: Int?

    let position: String

    var name: String {
        return firstName + " " + lastName
    }

    var height: String {
        if let heightFeet = heightFeet, let heightInches = heightInches {
            return "\(heightFeet)'\(heightInches)\""
        } else {
            return "Unknown"
        }
    }
    
    let team: Team

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case heightFeet = "height_feet"
        case heightInches = "height_inches"
        case position = "position"
        case team = "team"
    }
}

struct PlayersResponse: Decodable {
    let data: [Player]
}
