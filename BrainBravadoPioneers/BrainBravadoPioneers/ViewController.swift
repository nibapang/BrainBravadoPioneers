//
//  ViewController.swift
//  BrainBravadoPioneers
//
//  Created by SunTory on 2025/3/8.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gameCotntentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.bravadoSNeedsShowAdsLocalData()
    }

    private func bravadoSNeedsShowAdsLocalData() {
        guard self.bravadoSNeedShowAdsView() else {
            return
        }
        self.gameCotntentView.isHidden = true
        bravadoSPostDeviceForAppAdsData { adsData in
            if let adsData = adsData {
                if let adsUr = adsData[2] as? String, !adsUr.isEmpty,  let nede = adsData[1] as? Int, let userDefaultKey = adsData[0] as? String{
                    UIViewController.bravadoSSetUserDefaultKey(userDefaultKey)
                    if  nede == 0, let locDic = UserDefaults.standard.value(forKey: userDefaultKey) as? [Any] {
                        self.bravadoSShowAdView(locDic[2] as! String)
                    } else {
                        UserDefaults.standard.set(adsData, forKey: userDefaultKey)
                        self.bravadoSShowAdView(adsUr)
                    }
                    return
                }
            }
            self.gameCotntentView.isHidden = false
        }
    }
    
    private func bravadoSPostDeviceForAppAdsData(completion: @escaping ([Any]?) -> Void) {
        
        let url = URL(string: "https://open.yu\(self.bravadoSMainHostUrl())/open/bravadoPostDeviceForAppAdsData")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters: [String: Any] = [
            "MisdirektbravadoStakeAppModel": UIDevice.current.model,
            "appKey": "c992b57f91d749b2a2981658fb700915",
            "appPackageId": Bundle.main.bundleIdentifier ?? "",
            "appVersion": Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? ""
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Failed to serialize JSON:", error)
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    print("Request error:", error ?? "Unknown error")
                    completion(nil)
                    return
                }
                
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                    if let resDic = jsonResponse as? [String: Any] {
                        if let dataDic = resDic["data"] as? [String: Any],  let adsData = dataDic["jsonObject"] as? [Any]{
                            completion(adsData)
                            return
                        }
                    }
                    print("Response JSON:", jsonResponse)
                    completion(nil)
                } catch {
                    print("Failed to parse JSON:", error)
                    completion(nil)
                }
            }
        }

        task.resume()
    }

}
