//
//  ApiManager.swift
//  CooperColor
//
//  Created by Margaret Ikeda on 11/7/16.
//  Copyright © 2016 Margaret Ikeda. All rights reserved.
//

import Foundation

class ApiRequestManager {
    
    //MARK: - Properties
    static let manager = ApiRequestManager()
    
    //MARK: - Initializers
    private init() {}
    
    func getData(apiEndpoint: String, callback: @escaping (Image?) -> Void) {
        
        //1. get URL from apiEndpoint
        guard let url: URL = URL(string: apiEndpoint) else { return }
        
        //2.create URL Session
        let session: URLSession = URLSession.init(configuration: .default)
        
        //3.create task and pass data into closure
        session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Encountered an error: \(error)")
            }
            
            guard let jsonData = data else { return }
            let validImage = ApiRequestManager.manager.getImage(jsonData)
            callback(validImage)
            
            }.resume()
    }
    static func generateObject(from data: Data) -> Object? {
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
            let myImage = Image(from: imageDictFinal)
            return myImage
        } catch {
            print ("Error encountered when parsing")
            return nil
        }
        
    }

}
