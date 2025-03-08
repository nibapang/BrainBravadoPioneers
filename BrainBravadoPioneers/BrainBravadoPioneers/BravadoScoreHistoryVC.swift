//
//  BravadoScoreHistoryVC.swift
//  BrainBravadoPioneers
//
//  Created by SunTory on 2025/3/8.
//

import UIKit

class BravadoScoreHistoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var scoreHistory: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "BravadoScoreHistoryCell", bundle: nil), forCellReuseIdentifier: "BravadoScoreHistoryCell")
        loadScores()
    }
    
    func loadScores() {
        scoreHistory = UserDefaults.standard.array(forKey: "scoreHistory") as? [String] ?? []
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BravadoScoreHistoryCell", for: indexPath) as! BravadoScoreHistoryCell
        cell.configure(with: scoreHistory[indexPath.row])
        return cell
    }
    
    @IBAction func clearScores(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "scoreHistory")
        scoreHistory.removeAll()
        tableView.reloadData()
    }
}

