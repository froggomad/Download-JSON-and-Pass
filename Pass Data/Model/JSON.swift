//
//  JSON.swift
//  Pass Data
//
//  Created by Kenny on 6/23/19.
//  Copyright © 2019 Hazy Studios. All rights reserved.
//

import Foundation

class JsonHandler {
    var inputDict: [String:Any]?
    
    
    init(_ inputDict:[String:Any]) {
        //_ for unnamed variable - so it's called elsewhere like:
        //let json=JsonHandler(something) instead of:
        //let json=JsonHandler(inputDict: something)
        self.inputDict = inputDict
    }
    //This function takes an encodable and returns a JSON String - self.inputDict is used here
    func jsonifyDict() -> String {
        if let theJSONData = try?  JSONSerialization.data(
            withJSONObject: self.inputDict as Any,
            options: .prettyPrinted
            ),
            let jsonString = String(data: theJSONData,
                                     encoding: String.Encoding.ascii) {
            return jsonString
        }
        return "Invalid for JSON"
    }
    
    func something() {
        
        
    }
    
    
}

//usage:
//let str = "[{\"key\":\"value\"}]"
//let json = str.toJSON()
extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
