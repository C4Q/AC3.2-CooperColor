//
//  Object.swift
//  CooperColor
//
//  Created by Margaret Ikeda on 11/7/16.
//  Copyright © 2016 Margaret Ikeda. All rights reserved.
//

import Foundation

enum handleParseError: Error {
    case results(json: Any)
    case image(image: Any)
}

class Object {
    let objectId: Int
    let image: Image
    let objectUrl: URL
    
    init(objectId: Int, image: Image, objectUrl: URL) {
        self.objectId = objectId
        self.image = image
        self.objectUrl = objectUrl
    }
   }
