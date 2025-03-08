//
//  BravadoScoreHistoryCell.swift
//  BrainBravadoPioneers
//
//  Created by SunTory on 2025/3/8.
//

import UIKit

class BravadoScoreHistoryCell: UITableViewCell {

    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    func setupCell() {
        selectionStyle = .none
       
    }
    
    func configure(with score: String) {
        scoreLabel.text = score
    }
    
}
