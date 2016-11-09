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

