//
//  Object.swift
//  CooperColor
//
//  Created by Margaret Ikeda on 11/7/16.
//  Copyright © 2016 Margaret Ikeda. All rights reserved.
//

import Foundation
let randomObjectEndpoint = "https://api.collection.cooperhewitt.org/rest/?method=cooperhewitt.objects.getRandom&access_token=1c6fcc4a8c333c57340cc2e821101854&has_image=1"

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
    static func generateObject(from data: Data) -> [Object?]? {
        var objectsToReturn = [Object]()
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            guard let response = jsonData as? [String: AnyObject],
                let results = response["object"] as? [String: AnyObject] else {
                    throw handleParseError.results(json: jsonData)
                }
                
                if let objectIdString = results["id"] as? String {
                    let objectId = Int(objectIdString)
                    print("@@@@@@@@@@@@@@@@@@@got Data@@@@@@@@@@@@@@@@@@@@@@@")
                }
            guard let imageArray = results["images"] as? [[String:AnyObject]] else {
               return nil
              //  print("1111111111got image Array111111111111")
            }
            
            guard let imageDict = imageArray[0] as? [String: AnyObject] else {
                return nil
                //print("2222222222got image dict2222222222")
            }
            
            guard let imageDictFinal = imageDict["n"] as? [String: AnyObject] else {
                return nil
                //print("333333333333got final dict33333333333")
            }
            guard let height = imageDictFinal["height"] else {
                return nil
            }
            
//            if let imageUrlString = imageDictFinal["url"]
            
//                if let imageDictOne = results["images"] as? [[String: AnyObject]] else {
//                    throw handleParseError.results(json: jsonData)
//                    print("Error encountered parsing imageDictOne")
//                }
//                if let imageDictTwo = imageDictOne["n"] else {
//                    throw handleParseError.results(json: jsonData)
//                    print("Error encountered parsing imageDictTwo")
//                }
//                if let imageDictThree = imageDictTwo["url"] else {
//                    throw handleParseError.results(json: jsonData)
//                    print("Error encountered parsing imageDictThree")
//                }
//                guard let getValidImageUrl = imageDictThree as? String else {return nil}
//                let imageUrl = URL(getValidImageUrl)
//                    
//                }
//                guard let height = imageDictTwo["height"]
//                guard let width = imageDictTwo["width"]
//                
            } catch {
                print ("Error encountered when parsing")
            }
return [Object]()
    }
}
