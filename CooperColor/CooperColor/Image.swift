//
//  Image.swift
//  CooperColor
//
//  Created by Margaret Ikeda on 11/8/16.
//  Copyright © 2016 Margaret Ikeda. All rights reserved.
//

import Foundation

class Image {
    let height: Int
    let width: Int
    let imageUrl: URL
    
    init(height: Int, width: Int, imageURL: URL) {
        self.height = height
        self.width = width
        self.imageUrl = imageURL
    }
    
    convenience init?(from dict:[String: AnyObject]) {
        if let height = dict["height"] as? Int,
            let width = dict["width"] as? Int,
            let url = dict["url"] as? String,
            let validUrl = URL(string: url) {
                self.init(height: height, width: width, imageURL: validUrl)
        } else {
            return nil
        }
    }
}
