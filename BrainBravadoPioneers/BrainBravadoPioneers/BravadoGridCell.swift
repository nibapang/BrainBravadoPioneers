//
//  BravadoGridCell.swift
//  BrainBravadoPioneers
//
//  Created by SunTory on 2025/3/8.
//

import UIKit

class BravadoGridCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
    }
    
    func configure(isFilled: Bool) {
        backgroundColor = isFilled ? .black : .white
    }
}

