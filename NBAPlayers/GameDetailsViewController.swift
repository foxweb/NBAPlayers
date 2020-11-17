//
//  GameDetailsViewController.swift
//  NBAPlayers
//
//  Created by Aleksey Kurepin on 11.11.2020.
//

import UIKit

class GameDetailsViewController: UIViewController {
    
    @IBOutlet weak var homeTeamButton: UIButton!
    @IBOutlet weak var visitorTeamButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var game: Game?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = game?.title
        homeTeamButton.setTitle(game?.homeTeam.fullName, for: .normal)
        visitorTeamButton.setTitle(game?.visitorTeam.fullName, for: .normal)
        scoreLabel.text = game?.score
        dateLabel.text = game?.formattedDate
    }
    @IBAction func onHomeTeamButtonTap(_ sender: Any) {
        navigateToTeamDetailsViewController(team: game!.homeTeam)
    }
    @IBAction func onVisitorTeamButtonTap(_ sender: Any) {
        navigateToTeamDetailsViewController(team: game!.visitorTeam)
    }
    
    func navigateToTeamDetailsViewController(team: Team) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let teamDetailsViewController = storyboard.instantiateViewController(identifier: "TeamDetailsViewController") as! TeamDetailsViewController

        teamDetailsViewController.team = team

        navigationController?.pushViewController(teamDetailsViewController, animated: true)
    }
}
