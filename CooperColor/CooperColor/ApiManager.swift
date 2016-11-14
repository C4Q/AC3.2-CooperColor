//
//  ApiManager.swift
//  CooperColor
//
//  Created by Margaret Ikeda on 11/7/16.
//  Copyright © 2016 Margaret Ikeda. All rights reserved.
//

import Foundation

struct CooperHewittConstants {
    static let accessToken = "33963188b8c804c81e7f9c963d2fd4a7"
}

enum CooperHewittEndpoint: String {
    case getObject = "https://api.collection.cooperhewitt.org/rest/?method=cooperhewitt.objects.getRandom&access_token=%@&has_image=1"
    
    func configuredEndpointUrl() -> URL? {
        switch self {
        case .getObject: return URL(string: String(format: self.rawValue, CooperHewittConstants.accessToken))
        }
    }
}


class ApiRequestManager {
    
    //MARK: - Properties
    static let manager = ApiRequestManager()
    
    //MARK: - Initializers
    private init() {}
    
    func getCooperObject(callback: @escaping (CooperHewittRandomObject?) -> Void) {
        getData(apiEndpoint: .getObject, parser: CooperHewittRandomObjectParser(), callback: callback)
    }
    
    private func getData<T: Parsing>(apiEndpoint: CooperHewittEndpoint,
                         parser: T,
                         callback: @escaping (T.Response?) -> Void) {
        //1. get URL from apiEndpoint
        guard let url = apiEndpoint.configuredEndpointUrl() else {
            callback(nil)
            return
        }

        //2.create URL Session
        let session: URLSession = URLSession.shared

        //3.create task and pass data into closure
        session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Encountered an error: \(error)")
                callback(nil)
            }

            guard let data = data,
                let jsonData = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any]
                else {
                    callback(nil)
                    return
            }

            callback(parser.parse(dictionary: jsonData))

            }.resume()
    }
}
