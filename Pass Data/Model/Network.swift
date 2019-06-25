//
//  Network.swift
//  Pass Data
//
//  Created by Kenny on 6/24/19.
//  Copyright © 2019 Hazy Studios. All rights reserved.
//

import Foundation
import Alamofire

class Network {
    //accessible via Network.jsonOutput
    var jsonOutput = [String:Any]()
    
    var body = ""
    
    
    
    func makeGetRequest(url: String, completed: @escaping DownloadComplete) {
        Alamofire.request(url)
            .responseJSON { response in
                // check for errors
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET on /todos/1")
                    print(response.result.error!)
                    return
                }
                
                // make sure we got some JSON since that's what we expect
                guard let json = response.result.value as? [String: Any] else {
                    print("didn't get todo object as JSON from API")
                    if let error = response.result.error {
                        print("Error: \(error)")
                    }
                    return
                }
                // get and print the title
                guard let todoTitle = json["title"] as? String else {
                    print("Could not get todo title from JSON")
                    return
                }
                self.jsonOutput = json
                print("The title is: " + todoTitle)
                completed()
        }
    }
    //simple post request using params, not body
    func postParams(url: String, json: String, completed: @escaping DownloadComplete) {
        Alamofire.request(url, method: .post, parameters: [:], encoding: json as ParameterEncoding, headers: [:])
    }
    
    //post request using Body
    func postBody(url: String, json: String, completed: @escaping DownloadComplete) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let pjson = json
        let data = (pjson.data(using: .utf8))! as Data
        request.httpBody = data
        Alamofire.request(request).response { (response) in
            print(response)
            completed()
        }
    }
}


extension String: ParameterEncoding {
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        return request
    }
    
}


