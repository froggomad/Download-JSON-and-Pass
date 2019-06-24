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
}
