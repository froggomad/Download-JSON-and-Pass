//
//  ViewController.swift
//  Pass Data
//
//  Created by Kenny on 6/23/19.
//  Copyright © 2019 Hazy Studios. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    var json = [String:Any]()
    //segue isn't available from viewDidLoad()
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //instantiate a Network class
        let network = Network()
        //get your JSON using the Alamofire Library)
        network.makeGetRequest(url: "https://jsonplaceholder.typicode.com/todos/1") {
            //everything in this block runs after the download has completed
            self.json = network.jsonOutput
            self.parseJsonAndSegue()
        }
    }
    
    func parseJsonAndSegue() {
        //1. modify your JSON as necessary
        self.json["id"] = 2
        self.json["author"] = "Terry Brooks"
        
        //2. Segue, passing json
        self.performSegue(withIdentifier: "secondVC", sender: self.json)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "secondVC" {
            if let secondVC = segue.destination as? SecondViewController, let json = sender as? [String:Any] {
                //user.userDetails = userDetails
                secondVC.json = json
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
