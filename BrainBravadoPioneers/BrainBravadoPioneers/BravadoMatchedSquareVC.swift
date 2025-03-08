//
//  BravadoMatchedSquareVC.swift
//  BrainBravadoPioneers
//
//  Created by SunTory on 2025/3/8.
//

import UIKit

class BravadoMatchedSquareVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var grid1CollectionView: UICollectionView!
    @IBOutlet weak var grid2CollectionView: UICollectionView!
    @IBOutlet weak var resetButton: UIButton!
    
    let gridSize = 5
    var grid1 = Array(repeating: false, count: 25)
    var grid2 = Array(repeating: false, count: 25)
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        grid1CollectionView.delegate = self
        grid1CollectionView.dataSource = self
        grid2CollectionView.delegate = self
        grid2CollectionView.dataSource = self
        
        grid1CollectionView.isScrollEnabled = false
        grid2CollectionView.isScrollEnabled = false
        
        grid1CollectionView.register(UINib(nibName: "BravadoGridCell", bundle: nil), forCellWithReuseIdentifier: "BravadoGridCell")
        grid2CollectionView.register(UINib(nibName: "BravadoGridCell", bundle: nil), forCellWithReuseIdentifier: "BravadoGridCell")
        
        showGameRules() // Show rules before starting the game
    }
    
    func showGameRules() {
        let rulesMessage = """
        Welcome to Match grid!
        - The first grid is randomly filled.
        - Tap on the second grid to match it to the first one.
        - Once both grids match, you win!
        - Your score increases each time you win.
        - Click Reset to start over.
        Good luck!
        """
        
        let alert = UIAlertController(title: "Game Rules", message: rulesMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Start Game", style: .default, handler: { _ in
            self.setupRandomGrid()
        }))
        present(alert, animated: true)
    }
    
    func setupRandomGrid() {
        for i in 0..<25 {
            grid1[i] = Bool.random() // Randomly fill first grid
        }
        grid2 = Array(repeating: false, count: 25) // Reset second grid
        grid1CollectionView.reloadData()
        grid2CollectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BravadoGridCell", for: indexPath) as! BravadoGridCell
        
        let index = indexPath.item
        if collectionView == grid1CollectionView {
            cell.configure(isFilled: grid1[index])
        } else {
            cell.configure(isFilled: grid2[index])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == grid2CollectionView {
            let index = indexPath.item
            grid2[index].toggle()
            collectionView.reloadItems(at: [indexPath])
            checkWinCondition()
        }
    }
    
    func checkWinCondition() {
        if grid1 == grid2 {
            score += 1
            let alert = UIAlertController(title: "You Win!", message: "Both grids match!\nScore: \(score)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Next Round", style: .default, handler: { _ in
                self.setupRandomGrid()
            }))
            present(alert, animated: true)
        }
    }
    
    @IBAction func resetGame(_ sender: UIButton) {
        score = 0
        setupRandomGrid()
    }
}

extension BravadoMatchedSquareVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing = (CGFloat(gridSize) - 1) * 2
        let width = (collectionView.frame.width - totalSpacing) / CGFloat(gridSize)
        let height = (collectionView.frame.height - totalSpacing) / CGFloat(gridSize)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}

