//
//  webServiceAPI.swift
//  Movies
//
//  Created by Shimaa Hassan on 2/22/19.
//  Copyright © 2019 Shimaa Hassan. All rights reserved.
//

import Foundation
import UIKit

let movies_url = "http://api.themoviedb.org/3/discover/movie?api_key=acea91d2bff1c53e6604e4985b6989e2"
let image_url = "https://image.tmdb.org/t/p/w1280"

// get data from web service
class WebService: NSObject {
    
    static var share = WebService()
    
    func webConnection(urlString: String, completionHandler:  @escaping (_ result: [[String: Any]],_ pages: Int) -> ()){
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
                guard let pagesNo = jsonDict["total_pages"] as? Int else {
                    return
                }
                guard let results = jsonDict["results"] as? [[String: Any]] else {
                    return
                }
                completionHandler(results,pagesNo)
                return
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
}

// download image from url
extension UIImageView {
    //   imageView.downloadedFrom(link: url)
    
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleToFill) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

// get image from url
func get_image(_ url_str:String, _ imageView:UIImageView)
{
    if let url:URL = URL(string: url_str), url.host != nil {
        // This is a correct url
        DispatchQueue.main.async(execute: {
            imageView.alpha = 0
            
            UIView.animate(withDuration: 0 , animations: {
                imageView.alpha = 1.0
            })
        })
    } else {
        print("url  error is : ",url_str)
    }
}
