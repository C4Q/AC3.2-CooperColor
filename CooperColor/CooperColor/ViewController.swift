//
//  ViewController.swift
//  CooperColor
//
//  Created by Margaret Ikeda on 11/7/16.
//  Copyright © 2016 Margaret Ikeda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var object: CooperHewittRandomObject? {
        didSet {
            setupImageView()
        }
    }
    
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
        ApiRequestManager.manager.getCooperObject { [weak self] randomObject in
            guard let randomObject = randomObject else {
                return
            }
            print(randomObject)
            self?.object = randomObject
        }
    }
    
    func setupImageView() {
        object?.getImage(callback: { image in
            let update = { self.cooperObjectImageView.image = image }
            if Thread.isMainThread {
                update()
            } else {
                DispatchQueue.main.async {
                    update()
                }
            }
        })
    }
}

