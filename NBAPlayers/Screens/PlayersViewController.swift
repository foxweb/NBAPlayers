//
//  PlayersViewController.swift
//  NBAPlayers
//
//  Created by Aleksandr Anosov on 09.11.2020.
//

import UIKit

class PlayersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var reloadButton: UIButton!

    var players: [Player] = []
    let apiClient: ApiClient = ApiClientImpl()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true

        reloadData()
    }

    func showLoading() {
        activityIndicatorView.startAnimating()
        errorLabel.isHidden = true
        reloadButton.isHidden = true
    }

    func showData() {
        activityIndicatorView.stopAnimating()
        errorLabel.isHidden = true
        reloadButton.isHidden = true
    }

    func showError() {
        activityIndicatorView.stopAnimating()
        errorLabel.isHidden = false
        reloadButton.isHidden = false
    }

    func reloadData() {
        showLoading()
        apiClient.getPlayers(onResult: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let players):
                    self.players = players
                    self.tableView.reloadData()
                    self.showData()
                case .failure:
                    self.players = []
                    self.tableView.reloadData()
                    self.showError()
                }
            }
        })
    }

    @IBAction func onReloadButtonTap(_ sender: Any) {
        reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath)

        let player = players[indexPath.row]

        cell.textLabel?.text = player.name
        cell.detailTextLabel?.text = player.team.fullName

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let playersDetailViewController = storyboard.instantiateViewController(identifier: "PlayerDetailsViewController") as! PlayerDetailsViewController

        let player = players[indexPath.row]

        playersDetailViewController.player = player
        navigationController?.pushViewController(playersDetailViewController, animated: true)
    }

}
