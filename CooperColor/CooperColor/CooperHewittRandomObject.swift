//
//  Object.swift
//  CooperColor
//
//  Created by Margaret Ikeda on 11/7/16.
//  Copyright © 2016 Margaret Ikeda. All rights reserved.
//

import Foundation
import UIKit


enum handleParseError: Error {
    case results(json: Any)
    case image(image: Any)
}

class CooperHewittRandomObject {
    let objectId: String
    let objectUrl: URL
    private var image: UIImage? = nil
    
    init(objectId: String, objectUrl: URL) {
        self.objectId = objectId
        self.objectUrl = objectUrl
    }
    
    func getImage(callback: @escaping (UIImage?) -> Void) {
        
        if let _ = image { callback(image) }
        
        DispatchQueue.global().async { [weak self] in
            
            guard let url = self?.objectUrl else {
                callback(nil)
                return
            }
            
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                self?.image = image
                callback(image)
            }
            catch _ {
                callback(nil)
            }
        }
    }
}

extension CooperHewittRandomObject: CustomStringConvertible {
    var description: String {
        return "objectId: \(objectId) || url: \(objectUrl)"
    }
}
