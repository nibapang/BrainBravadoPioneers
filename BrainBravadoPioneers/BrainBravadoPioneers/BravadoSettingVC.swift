//
//  BravadoSettingVC.swift
//  BrainBravadoPioneers
//
//  Created by SunTory on 2025/3/8.
//

import UIKit
import StoreKit

class BravadoSettingVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
      @IBAction func btnRate(_ sender: Any) {
        
        SKStoreReviewController.requestReview()
        
    }
    
}
