//
//  webServiceAPI.swift
//  Movies
//
//  Created by Shimaa Hassan on 2/22/19.
//  Copyright © 2019 Shimaa Hassan. All rights reserved.
//

import Foundation
let movies_url = "http://api.themoviedb.org/3/discover/movie?api_key=acea91d2bff1c53e6604e4985b6989e2"


class WebService: NSObject {
    
    static var share = WebService()
    
    func webConnection(urlString: String, completionHandler:  @escaping (_ result: [[String: Any]]) -> ()){
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: [])
    //            print(jsonResponse) //Response result
                // dict
                guard let jsonDict = jsonResponse as? [String: Any] else {
                    return
                }
                // array of dict
                guard let results = jsonDict["results"] as? [[String: Any]] else {
                    return
                }
                completionHandler(results)
                return
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
}

