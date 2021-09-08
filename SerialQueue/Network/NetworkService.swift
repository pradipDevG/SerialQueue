//
//  NetworkService.swift
//  SerialQueue
//
//  Created by Pradip Gotame on 07/09/2021.
//

import Foundation

typealias RequestError = String
typealias ContentLength = String
typealias FavIconURL = String

class NetworkService: NSObject {
    static let shared = NetworkService()
    
    func fetchRequest(url: String,  completion: @escaping(RequestError, ContentLength, FavIconURL) -> ()) {
        let hURL = "https://" + url
        guard let requestURL = URL(string: hURL) else { return }
        URLSession.shared.dataTask(with: requestURL) { (data, resp, err) in
            
            if let err = err  {
                completion(err.localizedDescription, "\((err as NSError).code)", "")
                return
            }
            
            let favURL = "https://www.google.com/s2/favicons?sz=1024&domain=www." + url
            if let httpResponse = resp as? HTTPURLResponse, let length = httpResponse.value(forHTTPHeaderField: "Content-Length") {
                let intValue = NSString(string: length).integerValue
                let contentLength = (intValue < 1024) ? "\(intValue) KB" : "\(intValue/1024) MB"
                completion("", contentLength, favURL)
            } else {
                completion("", "0 KB", favURL)
            }
        }.resume()
    }
}
