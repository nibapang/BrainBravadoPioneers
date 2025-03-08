//
//  BravadoAlphabetBravadoGridCell.swift
//  BrainBravadoPioneers
//
//  Created by SunTory on 2025/3/8.
//

import UIKit

class BravadoAlphabetBravadoGridCell: UICollectionViewCell {
    
    @IBOutlet weak var letterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 5
    }
    
    func configure(with letter: Character) {
        letterLabel.text = String(letter)
    }
}
