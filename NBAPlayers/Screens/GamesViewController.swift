//
//  GamesViewController.swift
//  NBAPlayers
//
//  Created by Aleksey Kurepin on 11.11.2020.
//

import UIKit

class GamesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var games: [Game] = []
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
        apiClient.getGames(onResult: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let games):
                    self.games = games
                    self.tableView.reloadData()
                    self.showData()
                case .failure:
                    self.games = []
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
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)
        
        let game = games[indexPath.row]
        
        cell.textLabel?.text = game.title
        cell.detailTextLabel?.text = game.formattedDate
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let gameDetailsViewController = storyboard.instantiateViewController(identifier: "GameDetailsViewController") as! GameDetailsViewController

        let game = games[indexPath.row]

        gameDetailsViewController.game = game
        navigationController?.pushViewController(gameDetailsViewController, animated: true)
    }
}
