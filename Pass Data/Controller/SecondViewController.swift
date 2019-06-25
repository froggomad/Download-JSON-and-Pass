//
//  SecondViewController.swift
//  Pass Data
//
//  Created by Kenny on 6/23/19.
//  Copyright © 2019 Hazy Studios. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    //variable to receive jsonDict from ViewController
    var json = [String:Any]()
    
    //labels
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //convert ID int to string to display on label
        var id = "id"
        if let idString = json["id"] as? Int {
            id = String(idString)
        }
        //set labels with values from json
        nameLbl.text = json["title"] as? String
        idLbl.text = id
        authorLbl.text = json["author"] as? String
        //convert dict back to JSON String (to send back to server or html5 app maybe)
        postJson()
    }
    //if you need your JSON as a string
    func postJson() {
        let jsonHandler = JsonHandler(self.json)
        //JSON String with line breaks
        let jsonString = jsonHandler.jsonifyDict()
        let network = Network()
        network.postParams(url: "https://ptsv2.com/t/asdf/post", json: jsonString) {
            
        }
        
        network.postBody(url: "https://ptsv2.com/t/asdf/post", json: jsonString) {
            print("done")
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
