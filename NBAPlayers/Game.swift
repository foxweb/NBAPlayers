//
//  Game.swift
//  NBAPlayers
//
//  Created by Aleksey Kurepin on 11.11.2020.
//

import Foundation

struct Game: Decodable {
    let date: String?
    let homeTeamScore: Int
    let visitorTeamScore: Int
    let season: Int
    let period: Int
    let status: String
    
    let homeTeam: Team
    let visitorTeam: Team
    
    var score: String {
        return "\(homeTeamScore):\(visitorTeamScore)"
    }
    
    var formattedDate: String {
        if let rawDate = date {
            let dateFormatterGet = DateFormatter()
            let dateFormatterPrint = DateFormatter()

            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            dateFormatterPrint.dateFormat = "E, d MMM yyyy"
            
            if let dateAsDate = dateFormatterGet.date(from: rawDate) {
                return dateFormatterPrint.string(from: dateAsDate)
            } else {
                return "Unknown"
            }
        } else {
            return "Unknown"
        }
    }
    
    var title: String {
        return "\(homeTeam.fullName) — \(visitorTeam.fullName)"
    }
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case homeTeamScore = "home_team_score"
        case visitorTeamScore = "visitor_team_score"
        case season = "season"
        case period = "period"
        case status = "status"
        case homeTeam = "home_team"
        case visitorTeam = "visitor_team"
    }
}

struct GamesResponse: Decodable {
    let data: [Game]
}
