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
                    print("error calling GET on \(url)")
                    print(response.result.error!)
                    return
                }
                
                // make sure we have JSON
                guard let json = response.result.value as? [String: Any] else {
                    print("didn't get object as JSON from API")
                    if let error = response.result.error {
                        print("Error: \(error)")
                    }
                    return
                }
                // get and print the title
                guard let todoTitle = json["title"] as? String else {
                    print("Could not get title from JSON")
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
    
    //post request using Body showing error handling
    func postBody(url: String, json: String, completed: @escaping DownloadComplete) {
        var request = URLRequest(url: URL(string: url)!)
        //using POST method
        request.httpMethod = HTTPMethod.post.rawValue
        //MIME type for header
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //mutate json into data object
        let data = (json.data(using: .utf8))! as Data
        //make sure there's data before sending the request
        if !data.isEmpty {
            request.httpBody = data
        } else {
            print("nil or invalid JSON?: \(json)")
        }
        if request.httpBody != nil {
        Alamofire.request(request).response { (response) in
            guard response.error == nil else {
                print("Error: \(String(describing: response.error))")
                return
            }
                print(response)
                completed()
            }
            
        } else {
            print("body wasn't set")
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


