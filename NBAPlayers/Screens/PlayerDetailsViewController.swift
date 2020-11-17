//
//  PlayerDetailsViewController.swift
//  NBAPlayers
//
//  Created by Aleksandr Anosov on 09.11.2020.
//

import UIKit

class PlayerDetailsViewController: UIViewController {

    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var teamButton: UIButton!

    var player: Player?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = player?.name
        positionLabel.text = player?.position
        heightLabel.text = player?.height
        teamButton.setTitle(player?.team.fullName, for: .normal)
    }

    @IBAction func onTeamButtonTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let teamDetailsViewController = storyboard.instantiateViewController(identifier: "TeamDetailsViewController") as! TeamDetailsViewController

        teamDetailsViewController.team = player?.team

        navigationController?.pushViewController(teamDetailsViewController, animated: true)
    }

}
