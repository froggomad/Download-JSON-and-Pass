//
//  Globals.swift
//  Pass Data
//
//  Created by Kenny on 6/24/19.
//  Copyright © 2019 Hazy Studios. All rights reserved.
//

//completion block
/*Usage:
    function download(completed: @escaping DownloadComplete) {
        print("downloading")
 
        completed()
    }
 
   download() {
     print("Download Complete")
}
//prints "downloading" then "Download Complete"
*/
typealias DownloadComplete = () -> ()
