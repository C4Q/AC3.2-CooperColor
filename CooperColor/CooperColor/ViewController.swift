//
//  ViewController.swift
//  CooperColor
//
//  Created by Margaret Ikeda on 11/7/16.
//  Copyright © 2016 Margaret Ikeda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var object = [Object]()
    
    internal let randomObjectEndpoint: String = "https://api.collection.cooperhewitt.org/rest/?method=cooperhewitt.objects.getRandom&access_token=1c6fcc4a8c333c57340cc2e821101854&has_image=1"
    
    @IBOutlet weak var cooperObjectImageView: UIImageView!
    @IBOutlet weak var cooperTombstoneLabel: UILabel!
    
    @IBOutlet weak var topBgColorLabel: UILabel!
    @IBOutlet weak var middleBgColorLabel: UILabel!
    @IBOutlet weak var bottomBgColorLabel: UILabel!
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        cooperTombstoneLabel.text = "You pressed the button!"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRandomCooperObject(from: randomObjectEndpoint)
        ApiRequestManager.manager.getData(apiEndpoint: randomObjectEndpoint) { (data: Data?) in
            guard let validData = data else { return }
            if let validObject = Object.generateObject(from: validData) {
//                self.object = validObject
                
                DispatchQueue.main.async {
                }
            }
        }
            }
}

