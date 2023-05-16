//
//  main.swift
//  
//  Created by Rick Umali on 5/15/23.
//  Based on:
//  https://github.com/deege/deegeu-swift-rest-example/blob/master/deegeu-swift-rest-example/ViewController.swift

import Foundation

// From Xcode Help Documentation (URL Loading System)
func startLoad() {
    let url = URL(string: "https://www.example.com/")!
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print(error)
            return
        }
        guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
            print(response!)
            return
        }
        if let mimeType = httpResponse.mimeType, mimeType == "text/html",
            let data = data, let string = String(data: data, encoding: .utf8) {
            print(string)
        }
    }
    task.resume()
}

// From Deege U Code
func updateIP() {

    // Setup the session to make REST GET call.  Notice the URL is https NOT http!!
    let postEndpoint: String = "https://httpbin.org/ip"
    let session = URLSession.shared
    let url = URL(string: postEndpoint)!

    let task = session.dataTask(with: url) { data, response, error in
        guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
            print("Not a 200 response")
            return
        }

        // Read the JSON
        do {
            if let ipString = String(data:data!, encoding: String.Encoding.utf8) {
                // Print what we got from the call
                print(ipString)

                // Parse the JSON to get the IP
                let jsonDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                let origin = jsonDictionary["origin"] as! String
                print(origin)
            }
        } catch {
            print("bad things happened")
        }
    }
    task.resume()
}

updateIP()
print("Done")

