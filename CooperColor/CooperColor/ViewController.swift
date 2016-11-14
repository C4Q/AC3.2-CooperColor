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
    @IBOutlet weak var cooperObjectRefreshButton: UIButton!
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        getAndSetNewObject()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAndSetNewObject()
        
    }
    
    func getAndSetNewObject() {
        ApiRequestManager.manager.getCooperObject { [weak self] randomObject in
            guard let randomObject = randomObject else {
                return
            }
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

